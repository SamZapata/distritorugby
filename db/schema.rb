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

ActiveRecord::Schema.define(version: 2020_07_16_061012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

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

  create_table "game_club_coach_joins", force: :cascade do |t|
    t.integer "club_id"
    t.integer "coach_id"
    t.string "role"
    t.string "state"
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
    t.integer "mode"
    t.integer "club_category_id"
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
    t.integer "union_id"
    t.string "address"
    t.string "logo"
    t.string "alias"
    t.string "slug"
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
    t.string "slug"
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
    t.string "slug"
  end

  create_table "game_nn_teams", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_player_category_joins", force: :cascade do |t|
    t.integer "club_category_id"
    t.integer "player_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_player_cteam_joins", force: :cascade do |t|
    t.integer "club_team_id"
    t.integer "player_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "identification"
    t.date "birthdate"
    t.string "eps"
    t.float "weight"
    t.float "height"
    t.string "position"
    t.string "phone"
    t.string "injuries"
    t.text "about"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "club_team_id"
    t.string "slug"
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
    t.string "slug"
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
    t.string "slug"
  end

  create_table "game_unions", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.date "founded"
    t.string "website"
    t.string "logo"
    t.string "country"
    t.string "abbr"
    t.string "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
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
    t.string "slug"
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
    t.string "slug"
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
    t.bigint "story_id"
    t.bigint "tags_story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_tags_story_joins_on_story_id"
    t.index ["tags_story_id"], name: "index_tags_story_joins_on_tags_story_id"
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
