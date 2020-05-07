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

ActiveRecord::Schema.define(version: 2020_05_07_023101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.boolean "top_half"
    t.integer "place"
    t.boolean "fixed_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "total_cell", default: false
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["winner_id"], name: "index_games_on_winner_id"
  end

  create_table "participations", force: :cascade do |t|
    t.boolean "creator", default: false
    t.integer "place"
    t.integer "final_score"
    t.bigint "game_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_participations_on_game_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "value"
    t.bigint "game_id"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "submitter_id"
    t.datetime "deleted_at"
    t.index ["category_id"], name: "index_submissions_on_category_id"
    t.index ["deleted_at"], name: "index_submissions_on_deleted_at"
    t.index ["game_id"], name: "index_submissions_on_game_id"
    t.index ["submitter_id"], name: "index_submissions_on_submitter_id"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "big_boys", default: 0
    t.string "time_zone", default: "Asia/Seoul"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "games", "users", column: "winner_id"
  add_foreign_key "participations", "games"
  add_foreign_key "participations", "users"
  add_foreign_key "submissions", "categories"
  add_foreign_key "submissions", "games"
  add_foreign_key "submissions", "users"
  add_foreign_key "submissions", "users", column: "submitter_id"
end
