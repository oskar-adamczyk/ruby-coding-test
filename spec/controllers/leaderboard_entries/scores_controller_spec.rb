# frozen_string_literal: true

require "rails_helper"

RSpec.describe LeaderboardEntries::ScoresController, type: :controller do
  # given
  let!(:entry) { create :leaderboard_entry, score: 20, scores: build_list(:score, 2, :without_entry, value: 10) }
  let(:entry_id) { entry.id }
  let(:score) { entry.scores.first }
  let(:score_id) { score.id }

  describe "DELETE #destroy", type: :transactional do
    let(:destroy_call) { delete :destroy, params: { leaderboard_entry_id: entry_id, id: score_id }, session: {} }

    context "with valid params" do
      # when then
      it { expect { destroy_call }.to change(Score, :count).by(-1).and change { entry.reload.score }.by(-10) }
    end

    context "with not existing leaderboard entry" do
      # given
      let(:entry_id) { "not_existing" }

      # when then
      it { expect { destroy_call }.not_to change(Score, :count) }
    end

    context "with not existing score" do
      # given
      let!(:entry) { create :leaderboard_entry, score: 0, scores: build_list(:score, 2, :without_entry, value: 10) }

      # when then
      it { expect { destroy_call }.not_to change(Score, :count) }
    end
  end
end
