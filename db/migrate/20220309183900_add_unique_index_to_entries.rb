# frozen_string_literal: true

class AddUniqueIndexToEntries < ActiveRecord::Migration[5.2]
  def change
    add_index :leaderboard_entries, "lower(username), leaderboard_id", unique: true
    add_index :leaderboards, "lower(name)", unique: true
    change_column_null :leaderboard_entries, :username, false
    change_column_null :leaderboards, :name, false
  end
end
