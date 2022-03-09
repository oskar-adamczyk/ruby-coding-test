# frozen_string_literal: true

require "rails_helper"

RSpec.describe Leaderboard, type: :model do
  let!(:existing_leaderboard) { create :leaderboard }
  subject { build :leaderboard }

  it { is_expected.to be_valid_including_database }
  it { is_expected.to have_many :entries }
  it { is_expected.to validate_presence_of :name }
end
