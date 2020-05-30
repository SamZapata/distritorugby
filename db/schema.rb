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

ActiveRecord::Schema.define(version: 2020_05_30_014239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_category_schedules", force: :cascade do |t|
    t.string "day"
    t.time "start_time"
    t.time "end_time"
    t.integer "club_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_club_categories", force: :cascade do |t|
    t.string "name"
    t.string "branch"
    t.integer "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_club_matches", force: :cascade do |t|
    t.integer "club_id"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_club_teams", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "club_id"
  end

  create_table "game_clubs", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.string "picture"
    t.string "emb_location"
    t.string "phone"
    t.string "email"
    t.string "webpage"
    t.string "instagram"
    t.string "facebook"
    t.string "twitter"
    t.string "youtube"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_coach_team_joins", force: :cascade do |t|
    t.integer "club_team_id"
    t.integer "coach_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_coaches", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "identification"
    t.date "birthdate"
    t.string "eps"
    t.text "about"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_match_stats", force: :cascade do |t|
    t.integer "tries_a"
    t.integer "tries_b"
    t.integer "conversions_a"
    t.integer "conversions_b"
    t.integer "penalty_goal_a"
    t.integer "penalty_goal_b"
    t.integer "drop_goal_a"
    t.integer "drop_goal_b"
    t.integer "scrums_a"
    t.integer "scrums_b"
    t.integer "lines_a"
    t.integer "lines_b"
    t.integer "mauls_a"
    t.integer "mauls_b"
    t.integer "handling_a"
    t.integer "handling_b"
    t.integer "yellows_a"
    t.integer "yellows_b"
    t.integer "reds_a"
    t.integer "reds_b"
    t.integer "penalties_a"
    t.integer "penalties_b"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_matches", force: :cascade do |t|
    t.date "play_date"
    t.time "play_time"
    t.string "emb_location"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_nn_teams", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "identification"
    t.date "birthdate"
    t.string "eps"
    t.float "weigth"
    t.float "height"
    t.string "position"
    t.string "phone"
    t.string "injuries"
    t.text "about"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.integer "club_team_id"
  end

  create_table "game_referees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "identification"
    t.date "birthdate"
    t.string "eps"
    t.text "about"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_tournament_groups", force: :cascade do |t|
    t.string "name"
    t.integer "amount_teams"
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_tournaments", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.text "about"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "organizer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_unions", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.date "founded"
    t.string "website"
    t.string "logo"
    t.string "country"
    t.string "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.string "tags"
    t.text "talking"
    t.string "emb_video"
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "image_legend"
    t.string "video_legend"
  end

  create_table "stories", force: :cascade do |t|
    t.string "name"
    t.string "summary"
    t.text "body"
    t.string "emb_video"
    t.string "image"
    t.string "image_caption"
    t.string "video_caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tags", default: [], array: true
  end

  create_table "tags_news", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_news_joins", force: :cascade do |t|
    t.bigint "news_id"
    t.bigint "tags_news_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_id"], name: "index_tags_news_joins_on_news_id"
    t.index ["tags_news_id"], name: "index_tags_news_joins_on_tags_news_id"
  end

  create_table "tags_stories", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_story_joins", force: :cascade do |t|
    t.integer "story_id"
    t.integer "tags_story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_tournament_joins", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "tags_tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_tournaments", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.text "about"
    t.string "country"
    t.string "region"
    t.string "producer"
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

end
