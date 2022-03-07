# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Leaderboards", type: :request do
  describe "GET /leaderboards" do
    # given
    let!(:leaderboards) { create_list :leaderboard, 2 }

    # when
    before { get leaderboards_path }

    # then
    it { expect(response).to have_http_status :ok }
  end

  describe "GET /leaderboards/:id" do
    # given
    let!(:leaderboard) { create :leaderboard, entries: entries }
    let(:entries) { build_list(:leaderboard_entry, 2) << build(:leaderboard_entry, score: nil) }

    # when
    before { get leaderboard_path(id: leaderboard.id) }

    # then
    it { expect(response).to have_http_status :ok }
  end
end
