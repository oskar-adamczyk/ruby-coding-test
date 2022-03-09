# frozen_string_literal: true

require "rails_helper"
require "thwait"

describe ScoreServices::Create, type: :transactional do
  # when
  subject { described_class.call(**attributes) }

  # given
  let(:attributes) do
    { leaderboard_id: leaderboard_id, score: attributes_for(:score)[:value], username: username }
  end
  let(:username) { "John" }
  let!(:leaderboard) { create :leaderboard, entries: build_list(:leaderboard_entry, 2) }
  let(:leaderboard_id) { leaderboard.id }

  [
    [{ username: "John", score: 0 }, "minimum score"],
    [{ username: "John", score: 100 }, "maximum score"],
    [{ username: "Jane", score: Faker::Number.number(digits: 2) }, "new entry"]
  ].each do |subject_params, description|
    context "with #{description}" do
      # given
      let(:attributes) { super().merge(subject_params) }

      # then
      it { expect(subject).to be_a ScoreServices::Create::Result }
      it { expect(subject.score).to be_a Score }
      it { expect(subject.score.value).to eq subject_params[:score] }
    end
  end

  context "with calculating progress" do
    let!(:leaderboard) { create :leaderboard, entries: build_list(:leaderboard_entry, 2, :with_scores, score: 10) }
    let(:attributes) { super().merge(score: 20) }

    it { expect(subject.progress).to eq 2 }
  end

  context "with concurrent calls" do
    # given
    let!(:leaderboard) { create :leaderboard, entries: [entry] }
    let(:entry) { build(:leaderboard_entry, score: nil, username: username) }
    let(:attributes) do
      { leaderboard_id: leaderboard_id, score: 10, username: username }
    end

    # when
    before { ThreadsWait.all_waits(*2.times.map { Thread.new { described_class.call(**attributes) } }) }

    # then
    it { expect(entry.reload.score).to eq 20 }
  end

  [
    [{ score: -1 }, "lower than minimum score"],
    [{ score: 101 }, "higher than maximum score"],
    [{ score: "not_coercible_to_integer" }, "string score"],
    [{ leaderboard_id: "not_existing" }, "not existing leaderboard"]
  ].each do |subject_params, description|
    context "with #{description}" do
      # given
      let(:attributes) { super().merge(subject_params) }

      # then
      it { expect { subject }.to raise_error Errors::BaseError }
    end
  end
end
