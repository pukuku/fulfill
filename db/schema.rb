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

ActiveRecord::Schema.define(version: 2021_09_02_003321) do

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clips", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "share_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "content", null: false
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
  end

  create_table "helps", force: :cascade do |t|
    t.string "title", null: false
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "goal_id", null: false
    t.string "comment", null: false
    t.decimal "fulness", precision: 5, scale: 3, null: false
    t.integer "task_all", null: false
    t.integer "task_progress", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "post_date"
  end

  create_table "shares", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "goal_id", null: false
    t.integer "category_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_works", force: :cascade do |t|
    t.integer "goal_id", null: false
    t.integer "task_id", null: false
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "goal_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sun", default: "0", null: false
    t.string "mon", default: "0", null: false
    t.string "tue", default: "0", null: false
    t.string "wed", default: "0", null: false
    t.string "thu", default: "0", null: false
    t.string "fri", default: "0", null: false
    t.string "sat", default: "0", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "user_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
