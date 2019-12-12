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

ActiveRecord::Schema.define(version: 2019_12_12_050349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competence_matches", force: :cascade do |t|
    t.string "name"
    t.string "team1"
    t.string "team2"
    t.datetime "play_date"
    t.string "referee"
    t.string "field"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competence_stats", force: :cascade do |t|
    t.integer "trys_t1"
    t.integer "trys_t2"
    t.integer "conversion_t1"
    t.integer "conversion_t2"
    t.integer "dropgoal_t1"
    t.integer "dropgoal_t2"
    t.integer "penalties_t1"
    t.integer "penalties_t2"
    t.integer "yellows_t1"
    t.integer "yellows_t2"
    t.integer "reds_t1"
    t.integer "reds_t2"
    t.integer "tackles_t1"
    t.integer "tackles_t2"
    t.integer "scrums_t1"
    t.integer "scrums_t2"
    t.integer "won_scrums_t1"
    t.integer "won_scrums_t2"
    t.integer "lines_t1"
    t.integer "lines_t2"
    t.integer "won_lines_t1"
    t.integer "won_lines_t2"
    t.integer "mauls_t1"
    t.integer "mauls_t2"
    t.integer "possession_t1"
    t.integer "possession_t2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competence_tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_news", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "image"
    t.string "image_legend"
    t.string "emb_video"
    t.string "video_legend"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_stories", force: :cascade do |t|
    t.string "name"
    t.string "phrase"
    t.text "intro"
    t.text "body"
    t.datetime "birthdate"
    t.datetime "deathdate"
    t.string "image"
    t.string "img_caption"
    t.string "emb_video"
    t.string "video_caption"
    t.string "socialmedia", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_toolboxes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.string "video_embed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_drills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "figure"
    t.string "video_emb"
    t.string "time"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_equipment", force: :cascade do |t|
    t.string "name"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_goals", force: :cascade do |t|
    t.string "verb"
    t.string "howdo"
    t.string "moment"
    t.string "forwhat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_principles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "stage"
    t.string "image"
    t.string "video_emb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_skills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "keyfactors", array: true
    t.string "image"
    t.string "video_emb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_coaches", force: :cascade do |t|
    t.text "about"
    t.date "start_date"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_managers", force: :cascade do |t|
    t.text "about"
    t.date "start_date"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_players", force: :cascade do |t|
    t.text "about"
    t.date "start_date"
    t.integer "position"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_referees", force: :cascade do |t|
    t.text "about"
    t.date "start_date"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.integer "age"
    t.float "height"
    t.float "weight"
    t.string "nickname"
    t.string "phone"
    t.string "socialmedia"
    t.string "webpage"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
