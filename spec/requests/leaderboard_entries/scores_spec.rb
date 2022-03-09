# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Leaderboard entries Scores", type: :request do
  describe "DELETE /scores/:id", type: :transactional do
    # given
    let(:entry) do
      create :leaderboard_entry, score: 20, scores: build_list(:score, 2, :without_entry, value: 10)
    end
    let(:entry_id) { entry.id }
    let(:score) { entry.scores.first }
    let(:score_id) { score.id }

    # when
    before { delete leaderboard_entry_score_path(id: score_id, leaderboard_entry_id: entry_id) }

    context "with existing id" do
      # then
      it "should redirect to leaderboard and display success message" do
        expect(response).to redirect_to(entry.leaderboard)
        expect(flash[:notice]).not_to be_nil
        expect(flash[:error]).to be_nil
      end
    end

    context "with not existing score" do
      # given
      let(:score_id) { "not_existing" }

      # then
      it "should redirect to leaderboard and display error message" do
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be_nil
        expect(flash[:error]).not_to be_nil
      end
    end

    context "with not existing entry" do
      # given
      let(:entry_id) { "not_existing" }

      # then
      it "should redirect to leaderboard and display error message" do
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be_nil
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end
