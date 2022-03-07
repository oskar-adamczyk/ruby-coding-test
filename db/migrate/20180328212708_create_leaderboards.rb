# frozen_string_literal: true

class CreateLeaderboards < ActiveRecord::Migration[5.1]
  def change
    create_table :leaderboards do |t|
      t.string :name

      t.timestamps
    end
  end
end
