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

ActiveRecord::Schema.define(version: 20140420233744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discharges", force: true do |t|
    t.integer  "ipdays"
    t.boolean  "active"
    t.integer  "phpvisits"
    t.integer  "dropreason_id"
    t.string   "otherdetail"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "facility_id"
    t.string   "medikid"
    t.boolean  "ishidden",         default: false
    t.date     "ipdischargedate"
    t.date     "phpdischargedate"
    t.date     "phpstartdate"
    t.string   "gender",           default: "M"
  end

  create_table "dropreasons", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "ishidden",   default: false
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "ishidden",   default: false
  end

end
