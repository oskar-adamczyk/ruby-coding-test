# frozen_string_literal: true

module ScoreServices
  class Create
    ADD_SCORE_MAX_RETRIES = 10

    class Result < Dry::Struct
      include Dry.Types default: :nominal

      attribute :score, Strict::Any.constrained(type: Score)
    end

    def initialize(params)
      @params = params
    end

    def self.call(params)
      new(params).call
    end

    def call
      @score = Score.new

      ApplicationRecord.transaction isolation: :serializable do
        create_score!
      end
    rescue ActiveRecord::SerializationFailure => e
      Rails.logger.warn "SerializationFailure"

      raise_serialization_failure! e if max_retries_reached?

      @retry_attempt ||= 0
      @retry_attempt += 1

      sleep(rand / 100)
      retry
    end

    private

    attr_reader :params, :score

    def create_score!
      score.assign_attributes(entry: leaderboard_entry, value: params[:score])

      validate_score!

      score.save!
      leaderboard_entry.update!(score: leaderboard_entry.score.to_i + params[:score].to_i)

      Result.new score: score
    end

    def leaderboard
      @leaderboard ||= Leaderboard.find(params[:leaderboard_id])
    rescue ActiveRecord::RecordNotFound
      raise Errors::NotFound
    end

    def leaderboard_entry
      @leaderboard_entry ||= leaderboard.entries.find_or_initialize_by(username: params[:username])
    end

    def max_retries_reached?
      @retry_attempt == ADD_SCORE_MAX_RETRIES
    end

    def raise_serialization_failure!(error)
      @retry_attempt = nil
      raise error
    end

    def validate_score!
      return if score.valid?

      raise Errors::UnprocessableEntity.new entity: score
    end
  end
end
