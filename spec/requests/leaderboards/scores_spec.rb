# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Leaderboards Scores", type: :request do
  describe "POST /scores", type: :transactional do
    # given
    let(:score_attributes) do
      { score: attributes_for(:score)[:value], username: username }
    end
    let(:username) { Faker::Name.first_name }
    let!(:leaderboard) { create :leaderboard }
    let(:leaderboard_id) { leaderboard.id }

    # when
    before { post leaderboard_scores_path(leaderboard_id: leaderboard_id), params: { score: score_attributes } }

    context "with valid params" do
      # then
      it "should redirect to leaderboard and display success message" do
        expect(response).to redirect_to(leaderboard)
        expect(flash[:notice]).not_to be_nil
        expect(flash[:error]).to be_nil
      end
    end

    context "with not existing leaderboard" do
      # given
      let(:leaderboard_id) { "not_existing" }

      # then
      it "should redirect to leaderboard and display error message" do
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be_nil
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end
