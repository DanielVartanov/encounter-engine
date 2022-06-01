# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_24_073240) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_attempts", force: :cascade do |t|
    t.string "answer"
    t.bigint "play_id"
    t.bigint "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_answer_attempts_on_level_id"
    t.index ["play_id"], name: "index_answer_attempts_on_play_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hints", force: :cascade do |t|
    t.bigint "level_id"
    t.string "text"
    t.integer "delay_in_minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_hints_on_level_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.string "answer"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_levels_on_game_id"
  end

  create_table "plays", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "current_level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.datetime "reached_current_level_at", precision: nil
    t.datetime "finished_at", precision: nil
    t.bigint "latest_available_hint_id"
    t.index ["current_level_id"], name: "index_plays_on_current_level_id"
    t.index ["game_id"], name: "index_plays_on_game_id"
    t.index ["latest_available_hint_id"], name: "index_plays_on_latest_available_hint_id"
    t.index ["team_id"], name: "index_plays_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "answer_attempts", "levels"
  add_foreign_key "answer_attempts", "plays"
  add_foreign_key "hints", "levels"
  add_foreign_key "levels", "games"
  add_foreign_key "plays", "games"
  add_foreign_key "plays", "hints", column: "latest_available_hint_id"
  add_foreign_key "plays", "levels", column: "current_level_id"
  add_foreign_key "plays", "teams"
  add_foreign_key "users", "teams"
end
