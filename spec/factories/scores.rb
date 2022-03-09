# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    entry { build :leaderboard_entry }
    value { Faker::Number.number digits: 2 }
  end
end
