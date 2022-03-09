# frozen_string_literal: true

require "rails_helper"

RSpec.describe Score, type: :model do
  subject { build :score }

  it { is_expected.to be_valid_including_database }
  it { is_expected.to belong_to :entry }
  it { is_expected.to validate_numericality_of(:value).is_greater_than_or_equal_to 0 }
  it { is_expected.to validate_numericality_of(:value).is_less_than_or_equal_to 100 }
  it { is_expected.to validate_presence_of :value }
end
