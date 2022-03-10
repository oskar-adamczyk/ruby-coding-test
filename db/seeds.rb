# frozen_string_literal: true

require "database_cleaner"
require "faker"

def seed_leadeboard
  return Rails.logger.info "Leaderboard exists, skipping" if Leaderboard.find_by(name: "My Leaderboard")

  FactoryBot.create(
    :leaderboard, name: "My Leaderboard", entries: [
      FactoryBot.build(:leaderboard_entry, :with_scores, username: "Jane", score: 3),
      FactoryBot.build(:leaderboard_entry, :with_scores, username: "Jack", score: 10),
      FactoryBot.build(:leaderboard_entry, :with_scores, username: "John", score: 9),
      FactoryBot.build(:leaderboard_entry, username: "June")
    ]
  )
end

if ENV["CLEAR_DB"]
  raise "Do not clear DB on production environment" if Rails.env.production?

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
end

seed_leadeboard
