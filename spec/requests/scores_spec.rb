# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Scores", type: :request do
  describe "POST /scores" do
    # given
    let(:score_attributes) { attributes_for(:score).merge(leaderboard_id: leaderboard_id, username: username) }
    let(:username) { Faker::Name.first_name }
    let(:leaderboard) { create :leaderboard }
    let(:leaderboard_id) { leaderboard.id }

    # when
    before { post :create, params: { score: score_attributes }, session: {} }

    context "with valid params" do
      # then
      it "should redirect to leaderboard and display success message" do
        expect(response).to redirect_to(leaderboard)
        expect(expect(flash[:success])).not_to be_nil
        expect(expect(flash[:error])).to be_nil
      end
    end

    context "with not existing leaderboard" do
      # given
      let(:leaderboard_id) { "not_existing" }

      # then
      it "should redirect to leaderboard and display error message" do
        expect(response).to redirect_to(leaderboard)
        expect(expect(flash[:success])).to be_nil
        expect(expect(flash[:error])).not_to be_nil
      end
    end
  end
end
