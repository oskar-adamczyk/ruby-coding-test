# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :leaderboard_entry, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
