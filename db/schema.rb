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

ActiveRecord::Schema.define(version: 2019_11_25_164334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flats", force: :cascade do |t|
    t.bigint "user_id"
    t.string "address"
    t.text "description"
    t.integer "nb_rooms", default: 1
    t.integer "area"
    t.boolean "furnished", default: false
    t.string "syndic_name"
    t.string "syndic_phone"
    t.string "syndic_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_flats_on_user_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.bigint "flat_id"
    t.date "date"
    t.string "status", default: "pending"
    t.string "dispo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_incidents_on_flat_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "flat_id"
    t.date "start_date"
    t.integer "duration", default: 3
    t.integer "rent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_rentals_on_flat_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "rents", force: :cascade do |t|
    t.bigint "rental_id"
    t.string "status", default: "pending"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rental_id"], name: "index_rents_on_rental_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "flats", "users"
  add_foreign_key "incidents", "flats"
  add_foreign_key "rentals", "flats"
  add_foreign_key "rentals", "users"
end
