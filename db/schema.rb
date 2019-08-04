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

ActiveRecord::Schema.define(version: 2019_08_04_171905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.integer "employees", default: 0, null: false
    t.index ["name"], name: "index_departments_on_name", unique: true
  end

  create_table "rank_privileges", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.bigint "rank_id", null: false
    t.boolean "create", default: false, null: false
    t.boolean "read", default: false, null: false
    t.boolean "update", default: false, null: false
    t.boolean "delete", default: false, null: false
    t.index ["department_id"], name: "index_rank_privileges_on_department_id"
    t.index ["rank_id"], name: "index_rank_privileges_on_rank_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.string "name", limit: 128, null: false
    t.index ["department_id"], name: "index_ranks_on_department_id"
    t.index ["name"], name: "index_ranks_on_name", unique: true
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "firstname", limit: 128, null: false
    t.string "lastname", limit: 128, null: false
    t.string "email", limit: 128, null: false
    t.string "phonenumber", limit: 128, null: false
    t.string "address", limit: 128, null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.bigint "rank_id", null: false
    t.string "name", limit: 128, null: false
    t.string "password", limit: 128, null: false
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["rank_id"], name: "index_users_on_rank_id"
  end

  add_foreign_key "rank_privileges", "departments"
  add_foreign_key "rank_privileges", "ranks"
  add_foreign_key "ranks", "departments"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "ranks"
end
