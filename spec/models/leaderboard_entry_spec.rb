# frozen_string_literal: true

require "rails_helper"

RSpec.describe LeaderboardEntry, type: :model do
  let!(:existing_entry) { create :leaderboard_entry }
  subject { build :leaderboard_entry, leaderboard: existing_entry.leaderboard }

  it { is_expected.to be_valid_including_database }
  it { is_expected.to belong_to :leaderboard }
  it { is_expected.to have_many :scores }
  it { is_expected.to validate_uniqueness_of(:username).scoped_to(:leaderboard_id).case_insensitive }
  it { is_expected.to validate_presence_of :username }
end
