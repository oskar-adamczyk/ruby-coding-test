# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_09_183900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leaderboard_entries", force: :cascade do |t|
    t.bigint "leaderboard_id"
    t.string "username", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((username)::text), leaderboard_id", name: "index_leaderboard_entries_on_lower_username_leaderboard_id", unique: true
    t.index ["leaderboard_id"], name: "index_leaderboard_entries_on_leaderboard_id"
  end

  create_table "leaderboards", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_leaderboards_on_lower_name", unique: true
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "leaderboard_entry_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leaderboard_entry_id"], name: "index_scores_on_leaderboard_entry_id"
  end

  add_foreign_key "leaderboard_entries", "leaderboards"
  add_foreign_key "scores", "leaderboard_entries"
end
