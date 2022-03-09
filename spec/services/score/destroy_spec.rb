# frozen_string_literal: true

require "rails_helper"
require "thwait"

describe ScoreServices::Destroy, type: :transactional do
  # when
  subject { described_class.call(**attributes) }

  # given
  let(:entry) do
    create :leaderboard_entry, score: 30, scores: build_list(:score, 3, :without_entry, value: 10)
  end
  let(:entry_id) { entry.id }
  let(:score) { entry.scores.first }
  let(:score_id) { score.id }
  let(:attributes) { { leaderboard_entry_id: entry_id, score_id: score_id } }

  # then
  it { expect(subject).to be_a ScoreServices::Destroy::Result }

  context "with concurrent calls" do
    # given when
    before do
      ThreadsWait.all_waits(
        Thread.new { described_class.call(**{ leaderboard_entry_id: entry_id, score_id: score_id }) },
        Thread.new { described_class.call(**{ leaderboard_entry_id: entry_id, score_id: entry.scores.last.id }) }
      )
    end

    # then
    it { expect(entry.reload.score).to eq 10 }
  end

  [
    [{ leaderboard_entry_id: "not_existing" }, "not existing entry"],
    [{ score_id: "not_existing" }, "not existing score"]
  ].each do |subject_params, description|
    context "with #{description}" do
      # given
      let(:attributes) { super().merge(subject_params) }

      # then
      it { expect { subject }.to raise_error Errors::BaseError }
    end
  end
end
