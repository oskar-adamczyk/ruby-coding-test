# frozen_string_literal: true

class LeaderboardEntry < ApplicationRecord
  belongs_to :leaderboard
  has_many :scores, -> { order(created_at: :desc) }, dependent: :destroy, inverse_of: :entry

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false, scope: :leaderboard_id }
end
