# frozen_string_literal: true

module ScoreServices
  class Destroy < RetriableService
    class Result < Dry::Struct
      include Dry.Types default: :nominal
    end

    private

    attr_reader :params, :score

    def perform
      @score = find_score!
      validate_entry!

      leaderboard_entry.update!(score: new_score)
      score.destroy!

      Result.new
    end

    def find_score!
      Score.find(params[:score_id])
    rescue ActiveRecord::RecordNotFound
      raise Errors::NotFound
    end

    def leaderboard_entry
      @leaderboard_entry ||= LeaderboardEntry.find(params[:leaderboard_entry_id])
    rescue ActiveRecord::RecordNotFound
      raise Errors::NotFound
    end

    def new_score
      return nil if score.value == leaderboard_entry.score

      leaderboard_entry.score - score.value
    end

    def validate_entry!
      return if leaderboard_entry.score >= score.value

      score.errors.add(:entry, :invalid)
      raise Errors::UnprocessableEntity.new entity: score
    end
  end
end
