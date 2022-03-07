# frozen_string_literal: true

class Leaderboard < ApplicationRecord
  has_many :entries, class_name: "LeaderboardEntry", dependent: :destroy
end
