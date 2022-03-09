# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :entry, class_name: "LeaderboardEntry", foreign_key: :leaderboard_entry_id, inverse_of: :scores

  validates :value, presence: true
  validates :value, numericality: {
    allow_blank: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100,
    only_integer: true
  }
end
