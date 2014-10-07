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

ActiveRecord::Schema.define(version: 20141007223912) do

  create_table "bands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bands", ["name"], name: "index_bands_on_name", unique: true

  create_table "order_products", force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.integer  "order_id"
    t.decimal  "price",        precision: 8, scale: 2
    t.integer  "bonus_points"
  end

  add_index "order_products", ["order_id"], name: "index_order_product_on_order_id"
  add_index "order_products", ["product_id"], name: "index_order_product_on_product_id"

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bonus_points"
    t.string   "shipping_name"
    t.string   "shipping_last_name"
    t.string   "shipping_address"
    t.string   "shipping_town"
    t.string   "shipping_zip"
    t.string   "shipping_province"
    t.string   "shipping_country"
    t.string   "shipping_phone"
    t.boolean  "paid",               default: false
    t.string   "ref"
    t.string   "type"
    t.string   "state"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bonus_points",        default: 0
    t.boolean  "visible",             default: false
    t.string   "product_show_image"
    t.string   "product_index_image"
    t.text     "description"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "role",                   default: "user"
    t.integer  "points",                 default: 0
    t.string   "shipping_name"
    t.string   "shipping_last_name"
    t.string   "shipping_email"
    t.string   "shipping_address"
    t.string   "shipping_town"
    t.string   "shipping_zip"
    t.string   "shipping_province"
    t.string   "shipping_country"
    t.string   "shipping_phone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
