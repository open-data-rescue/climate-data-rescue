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

ActiveRecord::Schema.define(version: 20160407001538) do

  create_table "annotations", force: :cascade do |t|
    t.integer  "x_tl",             limit: 4
    t.integer  "y_tl",             limit: 4
    t.integer  "x_br",             limit: 4
    t.integer  "y_br",             limit: 4
    t.integer  "page_id",          limit: 4
    t.integer  "transcription_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date_time_id",     limit: 255
    t.integer  "field_group_id",   limit: 4
  end

  create_table "data_entries", force: :cascade do |t|
    t.string  "value",         limit: 255
    t.string  "data_type",     limit: 255
    t.integer "user_id",       limit: 4
    t.integer "page_id",       limit: 4
    t.integer "annotation_id", limit: 4
    t.integer "field_id",      limit: 4
  end

  create_table "field_groups", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "description",  limit: 255
    t.string   "help",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_type_id", limit: 4
  end

  create_table "fields", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "field_key",       limit: 255
    t.string   "html_field_type", limit: 255
    t.string   "initial_value",   limit: 255
    t.text     "options",         limit: 65535
    t.text     "validations",     limit: 65535
    t.integer  "field_group_id",  limit: 4
    t.string   "data_type",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ledgers", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "ledger_type", limit: 255
    t.string   "volume",      limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_types", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "ledger_type", limit: 255
    t.integer  "number",      limit: 4
    t.text     "description", limit: 65535
    t.integer  "ledger_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.integer  "height",               limit: 4
    t.integer  "width",                limit: 4
    t.integer  "order",                limit: 4
    t.integer  "page_type_id",         limit: 4
    t.boolean  "done",                             default: false, null: false
    t.integer  "classification_count", limit: 4,   default: 0,     null: false
    t.string   "accession_number",     limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",      limit: 255
    t.string   "image_content_type",   limit: 255
    t.integer  "image_file_size",      limit: 4
    t.datetime "image_updated_at"
    t.integer  "transcriber_id",       limit: 4
  end

  add_index "pages", ["page_type_id"], name: "index_pages_on_page_type_id", using: :btree

  create_table "transcriptions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "page_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete",             default: false, null: false
  end

  create_table "translations", force: :cascade do |t|
    t.string   "locale",         limit: 255
    t.string   "key",            limit: 255
    t.text     "value",          limit: 65535
    t.text     "interpolations", limit: 65535
    t.boolean  "is_proc",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "display_name",           limit: 255
    t.boolean  "admin"
    t.text     "bio",                    limit: 65535
    t.integer  "num_contributions",      limit: 4,     default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
