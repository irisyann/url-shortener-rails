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

ActiveRecord::Schema[7.0].define(version: 2023_03_22_035604) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "geolocations", force: :cascade do |t|
    t.bigint "short_url_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "country"
    t.index ["short_url_id"], name: "index_geolocations_on_short_url_id"
  end

  create_table "short_urls", force: :cascade do |t|
    t.integer "num_clicks", default: 0, null: false
    t.string "short_path", null: false
    t.bigint "target_url_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_url_id"], name: "index_short_urls_on_target_url_id"
  end

  create_table "target_urls", force: :cascade do |t|
    t.string "target_url", null: false
    t.string "title_tag", default: "Untitled", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_target_urls_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "geolocations", "short_urls"
  add_foreign_key "short_urls", "target_urls"
  add_foreign_key "target_urls", "users"
end
