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

ActiveRecord::Schema.define(version: 20170309040852) do

  create_table "stellar_lookout_operations", force: :cascade do |t|
    t.integer  "ward_id"
    t.text     "body",            null: false
    t.string   "txn_external_id", null: false
    t.string   "external_id",     null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["external_id"], name: "index_stellar_lookout_operations_on_external_id"
    t.index ["txn_external_id"], name: "index_stellar_lookout_operations_on_txn_external_id"
    t.index ["ward_id"], name: "index_stellar_lookout_operations_on_ward_id"
  end

  create_table "stellar_lookout_txns", force: :cascade do |t|
    t.string   "external_id", null: false
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["external_id"], name: "index_stellar_lookout_txns_on_external_id", unique: true
  end

  create_table "stellar_lookout_wards", force: :cascade do |t|
    t.string   "address",    null: false
    t.string   "secret",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_stellar_lookout_wards_on_address"
  end

end
