# frozen_string_literal: true

class LeaderboardEntry < ApplicationRecord
  belongs_to :leaderboard
  has_many :scores, dependent: :destroy
end
