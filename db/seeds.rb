# frozen_string_literal: true

require "database_cleaner"
require "faker"

if ENV["CLEAR_DB"]
  raise "Do not clear DB on production environment" if Rails.env.production?

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
end

FactoryBot.create(
  :leaderboard, name: "My Leaderboard", entries: [
    FactoryBot.build(:leaderboard_entry, username: "Jack", score: 10),
    FactoryBot.build(:leaderboard_entry, username: "John", score: 9),
    FactoryBot.build(:leaderboard_entry, username: "Jane", score: 3),
    FactoryBot.build(:leaderboard_entry, username: "June", score: nil)
  ]
)
