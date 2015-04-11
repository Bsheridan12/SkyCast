# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150411190411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_forecasts", force: :cascade do |t|
    t.integer  "time"
    t.text     "summary"
    t.text     "icon"
    t.integer  "sunrise_time"
    t.integer  "sunset_time"
    t.float    "precip_probability"
    t.float    "temperature_min"
    t.integer  "temperature_min_time"
    t.float    "temperature_max"
    t.integer  "temperature_max_time"
    t.float    "humidity"
    t.float    "wind_speed"
    t.float    "visiblity"
    t.integer  "location_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "hourly_forecasts", force: :cascade do |t|
    t.integer  "time"
    t.text     "summary"
    t.text     "icon"
    t.float    "precip_probability"
    t.float    "temperature"
    t.float    "humidity"
    t.float    "wind_speed"
    t.float    "visiblity"
    t.integer  "location_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_locations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.text     "image_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
