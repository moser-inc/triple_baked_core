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

ActiveRecord::Schema[8.0].define(version: 2015_06_10_143438) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "spud_permissions", force: :cascade do |t|
    t.string "name", null: false
    t.string "tag", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tag"], name: "index_spud_permissions_on_tag", unique: true
  end

  create_table "spud_role_permissions", force: :cascade do |t|
    t.integer "spud_role_id", null: false
    t.string "spud_permission_tag", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["spud_permission_tag"], name: "index_spud_role_permissions_on_spud_permission_tag"
    t.index ["spud_role_id"], name: "index_spud_role_permissions_on_spud_role_id"
  end

  create_table "spud_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spud_user_settings", force: :cascade do |t|
    t.integer "spud_user_id"
    t.string "key"
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spud_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.boolean "super_admin"
    t.string "login", null: false
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "password_salt", null: false
    t.string "persistence_token", null: false
    t.string "single_access_token", null: false
    t.string "perishable_token", null: false
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip"
    t.string "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "time_zone"
    t.integer "spud_role_id"
    t.boolean "requires_password_change", default: false
    t.index ["email"], name: "index_spud_users_on_email"
    t.index ["login"], name: "index_spud_users_on_login"
    t.index ["spud_role_id"], name: "index_spud_users_on_spud_role_id"
  end
end
