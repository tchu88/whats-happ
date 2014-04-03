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

ActiveRecord::Schema.define(version: 20140403063824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "message",                              null: false
    t.decimal  "longitude",    precision: 9, scale: 6, null: false
    t.decimal  "latitude",     precision: 9, scale: 6, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publisher_id"
  end

  add_index "events", ["publisher_id"], name: "index_events_on_publisher_id", using: :btree

  create_table "publishers", force: true do |t|
    t.string   "title",      null: false
    t.string   "url",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publishers", ["title"], name: "index_publishers_on_title", unique: true, using: :btree
  add_index "publishers", ["url"], name: "index_publishers_on_url", unique: true, using: :btree

  create_table "subscriptions", force: true do |t|
    t.string   "phone",                              null: false
    t.integer  "radius",                             null: false
    t.decimal  "longitude",  precision: 9, scale: 6, null: false
    t.decimal  "latitude",   precision: 9, scale: 6, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["phone"], name: "index_subscriptions_on_phone", using: :btree

end
