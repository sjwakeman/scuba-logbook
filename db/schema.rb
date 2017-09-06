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

ActiveRecord::Schema.define(version: 20170904232321) do

  create_table "dives", force: :cascade do |t|
    t.integer "dive_number"
    t.string  "date"
    t.string  "location"
    t.string  "visability"
    t.integer "bottom_time_to_date"
    t.integer "bottom_time_this_dive"
    t.integer "accumulated_time"
    t.integer "dive_start"
    t.integer "dive_end"
    t.text    "dive_comments"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
