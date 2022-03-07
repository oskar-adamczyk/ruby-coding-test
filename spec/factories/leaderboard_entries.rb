# frozen_string_literal: true

FactoryBot.define do
  factory :leaderboard_entry do
    leaderboard
    score { Faker::Number.number digits: 2 }
    username { Faker::Name.first_name }

    trait :without_leaderboard do
      leaderboard { nil }
    end
  end
end
