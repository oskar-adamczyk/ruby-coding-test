# frozen_string_literal: true

module ScoreServices
  class Create < RetriableService
    ADD_SCORE_MAX_RETRIES = 10

    class Result < Dry::Struct
      include Dry.Types default: :nominal

      attribute :score, Strict::Any.constrained(type: Score)
    end

    private

    attr_reader :params, :score

    def leaderboard
      @leaderboard ||= Leaderboard.find(params[:leaderboard_id])
    rescue ActiveRecord::RecordNotFound
      raise Errors::NotFound
    end

    def leaderboard_entry
      @leaderboard_entry ||= leaderboard.entries.find_or_initialize_by(username: params[:username])
    end

    def perform
      @score = Score.new

      persist_score!

      Result.new score: score
    end

    def persist_score!
      score.assign_attributes(entry: leaderboard_entry, value: params[:score])

      validate_score!

      score.save!
      leaderboard_entry.update!(score: leaderboard_entry.score.to_i + params[:score].to_i)
    end

    def validate_score!
      return if score.valid?

      raise Errors::UnprocessableEntity.new entity: score
    end
  end
end
