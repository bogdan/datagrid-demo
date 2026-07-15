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

ActiveRecord::Schema[8.1].define(version: 2026_07_15_084248) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.date "date"
    t.float "hours"
    t.integer "project_id"
    t.integer "user_id"
    t.index "EXTRACT(month FROM date)", name: "date_month"
    t.index "EXTRACT(year FROM date)", name: "date_year"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "disabled", default: false, null: false
    t.string "email"
    t.integer "logins_count", default: 0, null: false
    t.string "name"
    t.datetime "registered_at"
    t.string "registration_type"
    t.datetime "updated_at", null: false
  end
end
