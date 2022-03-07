# frozen_string_literal: true

FactoryBot.define do
  factory :leaderboard do
    name { Faker::Company.name }

    trait :with_entries do
      entries { build_list :leaderboard_entry, 2 }
    end
  end
end
