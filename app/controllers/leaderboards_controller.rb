# frozen_string_literal: true

class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: %i[show edit update destroy add_score]

  ADD_SCORE_MAX_RETRIES = 5

  # GET /leaderboards
  def index
    @leaderboards = Leaderboard.all
  end

  # GET /leaderboards/1
  def show; end

  # GET /leaderboards/new
  def new
    @leaderboard = Leaderboard.new
  end

  # GET /leaderboards/1/edit
  def edit; end

  # POST /leaderboards
  def create
    @leaderboard = Leaderboard.new(leaderboard_params)

    if @leaderboard.save
      redirect_to @leaderboard, notice: "Leaderboard was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /leaderboards/1
  def update
    if @leaderboard.update(leaderboard_params)
      redirect_to @leaderboard, notice: "Leaderboard was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /leaderboards/1
  def destroy
    @leaderboard.destroy
    redirect_to leaderboards_url, notice: "Leaderboard was successfully destroyed."
  end

  def add_score
    update_score
    redirect_to @leaderboard, notice: "Score added"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_leaderboard
    @leaderboard = Leaderboard.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def leaderboard_params
    params.require(:leaderboard).permit(:name)
  end

  def update_score
    ApplicationRecord.transaction isolation: :serializable do
      persist_score
    end
  rescue ActiveRecord::SerializationFailure => e
    Rails.logger.warn "SerializationFailure"

    raise_serialization_failure! e if max_retries_reached?

    @retry_attempt ||= 0
    @retry_attempt += 1

    sleep(rand / 100)
    retry
  end

  def persist_score
    username = params[:username]
    score = params[:score]
    if @leaderboard.entries.exists?(username: username)
      entry = @leaderboard.entries.where(username: username).first
      entry.update!(score: score.to_i + entry.score.to_i)
    else
      @leaderboard.entries.create(username: username, score: score)
    end
  end

  def max_retries_reached?
    @retry_attempt == ADD_SCORE_MAX_RETRIES
  end

  def raise_serialization_failure!(error)
    @retry_attempt = nil
    raise error
  end
end
