# frozen_string_literal: true

module Leaderboards
  class ScoresController < ApplicationController
    before_action :set_leaderboard

    rescue_from ActiveRecord::RecordNotFound, with: :leaderboard_not_found
    rescue_from Errors::UnprocessableEntity, with: :invalid_score

    def create
      ScoreServices::Create.call(score_params)
      redirect_to @leaderboard, flash: { notice: "Score added" }
    end

    private

    def invalid_score
      redirect_to @leaderboard, flash: { error: "Invalid score" }
    end

    def leaderboard_not_found
      redirect_to root_path, flash: { error: "Leaderboard not found" }
    end

    def score_params
      params.require(:score).permit(:username, :score).to_h.merge(leaderboard_id: params[:leaderboard_id])
    end

    def set_leaderboard
      @leaderboard = Leaderboard.find(params[:leaderboard_id])
    end
  end
end
