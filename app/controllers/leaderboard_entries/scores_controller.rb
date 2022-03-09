# frozen_string_literal: true

module LeaderboardEntries
  class ScoresController < ApplicationController
    before_action :set_entry

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from Errors::NotFound, with: :not_found
    rescue_from Errors::UnprocessableEntity, with: :invalid_score

    def destroy
      ScoreServices::Destroy.call(leaderboard_entry_id: params[:leaderboard_entry_id], score_id: params[:id])
      redirect_to @entry.leaderboard, flash: { notice: "Score removed" }
    end

    private

    def invalid_score
      redirect_to @entry.leaderboard, flash: { error: "Invalid score" }
    end

    def not_found
      redirect_to root_path, flash: { error: "Resource not found" }
    end

    def set_entry
      @entry = LeaderboardEntry.find(params[:leaderboard_entry_id])
    end
  end
end
