# frozen_string_literal: true

module ScoreServices
  class Create < RetriableService
    ADD_SCORE_MAX_RETRIES = 10

    class Result < Dry::Struct
      include Dry.Types default: :nominal

      attribute :progress, Strict::Integer
      attribute :score, Strict::Any.constrained(type: Score)
    end

    private

    attr_reader :params, :score

    def perform
      @score = Score.new
      old_position = calculate_position

      persist_score!

      progress = old_position - calculate_position

      Result.new progress: progress, score: score
    end

    def calculate_position
      leaderboard_entry.leaderboard.entries.where(
        LeaderboardEntry.arel_table[:score].gt(leaderboard_entry.score || 0)
      ).count + 1
    end

    def leaderboard
      @leaderboard ||= Leaderboard.find(params[:leaderboard_id])
    rescue ActiveRecord::RecordNotFound
      raise Errors::NotFound
    end

    def leaderboard_entry
      @leaderboard_entry ||= leaderboard.entries.find_or_initialize_by(username: params[:username])
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
