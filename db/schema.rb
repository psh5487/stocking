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

ActiveRecord::Schema.define(version: 20170810063758) do

  create_table "bags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "one_hund_brand_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "logos", force: :cascade do |t|
    t.string   "firm_title"
    t.string   "logo_src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "one_hund_brands", force: :cascade do |t|
    t.string   "brand_img_src"
    t.string   "brand_title"
    t.string   "brand_number"
    t.integer  "brand_price"
    t.integer  "brand_eps"
    t.integer  "brand_bps"
    t.float    "brand_per"
    t.float    "brand_bizper"
    t.float    "brand_pbr"
    t.float    "brand_cashprofitratio"
    t.float    "brand_beta"
    t.float    "brand_bizprofitratio"
    t.float    "brand_netincomeratio"
    t.float    "brand_roe"
    t.float    "brand_dpsr"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
