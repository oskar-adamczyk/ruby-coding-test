# frozen_string_literal: true

require "rails_helper"

RSpec.describe LeaderboardEntriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/leaderboard_entries").to route_to("leaderboard_entries#index")
    end

    it "routes to #new" do
      expect(get: "/leaderboard_entries/new").to route_to("leaderboard_entries#new")
    end

    it "routes to #show" do
      expect(get: "/leaderboard_entries/1").to route_to("leaderboard_entries#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/leaderboard_entries/1/edit").to route_to("leaderboard_entries#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/leaderboard_entries").to route_to("leaderboard_entries#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/leaderboard_entries/1").to route_to("leaderboard_entries#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/leaderboard_entries/1").to route_to("leaderboard_entries#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/leaderboard_entries/1").to route_to("leaderboard_entries#destroy", id: "1")
    end
  end
end
