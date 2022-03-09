# frozen_string_literal: true

FactoryBot.define do
  factory :leaderboard do
    sequence(:name) { |i| "#{Faker::Company.name}#{i}" }

    trait :with_entries do
      entries { build_list :leaderboard_entry, 2, :with_scores }
    end
  end
end
