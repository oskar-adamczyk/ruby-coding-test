# frozen_string_literal: true

require "rails_helper"

RSpec.describe ScoresController, type: :controller do
  # given
  let(:score_attributes) { attributes_for(:score).merge(leaderboard_id: leaderboard_id, username: username) }
  let(:username) { Faker::Name.first_name }
  let(:leaderboard) { create :leaderboard }
  let(:leaderboard_id) { leaderboard.id }

  describe "POST #create" do
    let(:create_call) { post :create, params: { score: score_attributes }, session: {} }

    context "with valid params" do
      # when then
      it { expect { create_call }.to change(Score, :count).by(1).and change(LeaderboardEntry, :count).by 1 }
    end

    context "with not existing leaderboard" do
      # given
      let(:leaderboard_id) { "not_existing" }

      # when then
      it { expect { create_call }.not_to change(Score, :count) }
    end
  end
end
