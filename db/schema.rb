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

ActiveRecord::Schema.define(version: 2020_04_12_224906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
