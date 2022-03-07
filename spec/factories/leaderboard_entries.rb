# frozen_string_literal: true

FactoryBot.define do
  factory :leaderboard_entry do
    leaderboard
    score { Faker::Number.number 2 }
    username { Faker::Name.first_name }
  end
end
