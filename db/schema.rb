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

ActiveRecord::Schema[7.1].define(version: 2025_04_28_223802) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tea_subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "tea_id", null: false
    t.string "frequency"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.tsvector "search_vector"
    t.index ["customer_id"], name: "index_tea_subscriptions_on_customer_id"
    t.index ["search_vector"], name: "index_tea_subscriptions_on_search_vector", using: :gin
    t.index ["tea_id"], name: "index_tea_subscriptions_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "brew_time"
    t.integer "temperature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tea_subscriptions", "customers"
  add_foreign_key "tea_subscriptions", "teas"
end
