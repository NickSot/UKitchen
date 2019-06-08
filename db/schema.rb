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

ActiveRecord::Schema.define(version: 2019_06_08_165906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.integer "administrator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "weekly_budget", precision: 10, scale: 2, default: "0.0"
    t.decimal "current_budget_state", precision: 10, scale: 2, default: "0.0"
    t.date "budget_duedate", default: DateTime.now.to_date
  end

  create_table "families_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "family_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.decimal "price", precision: 10, scale: 2
    t.integer "shopping_list_id"
    t.integer "family_id"
    t.boolean "bought", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "quantity", precision: 10, scale: 2
    t.string "quantity_unit"
    t.integer "items_enum_id"
  end

  create_table "items_enums", force: :cascade do |t|
    t.string "name"
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.string "name"
    t.integer "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "category_name"
    t.decimal "price", precision: 10, scale: 2
    t.string "price_unit"
    t.integer "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
