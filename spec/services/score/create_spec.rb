# frozen_string_literal: true

require "rails_helper"

describe ScoreServices::Create do
  # when
  subject { described_class.call(**attributes) }

  # given
  let(:attributes) { attributes_for(:score).merge(leaderboard_id: leaderboard_id, username: username) }
  let(:username) { Faker::Name.first_name }
  let(:leaderboard) { create :leaderboard }
  let(:leaderboard_id) { leaderboard.id }

  [
    [{ leaderboard_id: leaderboard_id, username: username, score: 0 }, "minimum score"],
    [{ leaderboard_id: leaderboard_id, username: username, score: 100 }, "maximum score"]
  ].each do |subject_params, description|
    context "with #{description}" do
      # given
      let(:attributes) { subject_params }

      # then
      it { expect(subject).to be_a ScoreServices::Create::Result }
      it { expect(subject.score).to be_a Score }
      it { expect(subject.score.value).to eq subject_params[:score] }
    end
  end

  [
    [{ leaderboard_id: leaderboard_id, username: username, score: -1 }, "lower than minimum score"],
    [{ leaderboard_id: leaderboard_id, username: username, score: 101 }, "higher than maximum score"],
    [{ leaderboard_id: "not_existing", username: username, score: 101 }, "higher than maximum score"],
  ].each do |subject_params, description|
    context "with #{description}" do
      # given
      let(:attributes) { subject_params }

      # then
      it { expect { subject }.to raise_error Errors::BaseError }
    end
  end
end
