# frozen_string_literal: true

FactoryBot.define do
  factory :leaderboard_entry do
    leaderboard
    score { nil }
    sequence(:username) { |i| "#{Faker::Name.first_name}#{i}" }

    trait :with_scores do
      score { Faker::Number.number digits: 2 }
      scores { build_list :score, 1, value: score }
    end

    trait :without_leaderboard do
      leaderboard { nil }
    end
  end
end
