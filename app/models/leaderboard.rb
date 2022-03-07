# frozen_string_literal: true

class Leaderboard < ApplicationRecord
  has_many :entries,
           -> { order("COALESCE(score, 0) DESC") },
           class_name: "LeaderboardEntry",
           dependent: :destroy,
           inverse_of: :leaderboard
end
