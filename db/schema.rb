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

ActiveRecord::Schema.define(version: 20150420030432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "invoices", force: :cascade do |t|
    t.integer  "user_id",                                            null: false
    t.string   "email",                                              null: false
    t.decimal  "cost",         precision: 8, scale: 2, default: 0.0, null: false
    t.string   "state",                                              null: false
    t.datetime "deleted_at"
    t.hstore   "product_cart",                         default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["created_at"], name: "index_invoices_on_created_at", using: :btree

  create_table "product_images", force: :cascade do |t|
    t.integer "product_id"
    t.string  "asset",                      null: false
    t.boolean "main",       default: false, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",                                             null: false
    t.text     "description"
    t.string   "maker"
    t.integer  "count",                               default: 0,   null: false
    t.decimal  "price",       precision: 8, scale: 2, default: 0.0, null: false
    t.hstore   "properties",                          default: {}
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products_invoices", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "invoice_id", null: false
  end

  add_index "products_invoices", ["product_id", "invoice_id"], name: "index_products_invoices_on_product_id_and_invoice_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id",                                           null: false
    t.string   "type",                                              null: false
    t.decimal  "value",       precision: 8, scale: 2, default: 0.0, null: false
    t.string   "state",                                             null: false
    t.datetime "deleted_at"
    t.integer  "target_id"
    t.string   "target_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                          default: "",  null: false
    t.string   "encrypted_password",                             default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "credit",                 precision: 8, scale: 2, default: 0.0, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
