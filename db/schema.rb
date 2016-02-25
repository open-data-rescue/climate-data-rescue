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

ActiveRecord::Schema.define(version: 20160224104701) do

  create_table "albums", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "annotations", force: :cascade do |t|
    t.text     "bounds",           limit: 65535
    t.text     "data",             limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "transcription_id", limit: 4
    t.integer  "asset_id",         limit: 4
    t.integer  "fieldgroup_id",    limit: 4
  end

  add_index "annotations", ["asset_id"], name: "index_annotations_on_asset_id", using: :btree
  add_index "annotations", ["fieldgroup_id"], name: "index_annotations_on_entity_id", using: :btree
  add_index "annotations", ["transcription_id"], name: "index_annotations_on_transcription_id", using: :btree

  create_table "fieldgroups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "help",        limit: 255
    t.boolean  "resizable",   limit: 1
    t.integer  "width",       limit: 4
    t.integer  "height",      limit: 4
    t.text     "bounds",      limit: 65535
    t.float    "zoom",        limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "pagetype_id", limit: 4
  end

  add_index "fieldgroups", ["pagetype_id"], name: "index_fieldgroups_on_pagetype_id", using: :btree

  create_table "fields", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "field_key",     limit: 255
    t.string   "kind",          limit: 255
    t.string   "initial_value", limit: 255
    t.text     "options",       limit: 65535
    t.text     "validations",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "fieldgroup_id", limit: 4
    t.string   "data_type",     limit: 255
  end

  add_index "fields", ["fieldgroup_id"], name: "index_fields_on_entity_id", using: :btree

  create_table "ledgers", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "author",     limit: 255
    t.string   "extern_ref", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pages", force: :cascade do |t|
    t.integer  "height",               limit: 4
    t.integer  "width",                limit: 4
    t.integer  "display_width",        limit: 4
    t.string   "ext_ref",              limit: 255
    t.integer  "order",                limit: 4
    t.boolean  "done",                 limit: 1
    t.integer  "classification_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "upload_file_name",     limit: 255
    t.string   "upload_content_type",  limit: 255
    t.integer  "upload_file_size",     limit: 4
    t.datetime "upload_updated_at"
    t.integer  "transcription_id",     limit: 4
    t.string   "name",                 limit: 255
    t.integer  "pagetype_id",          limit: 4
    t.string   "accession_number",     limit: 255
    t.string   "ledger_id",            limit: 255
    t.string   "ledger_volume",        limit: 255
    t.date     "from_date"
    t.date     "to_date"
  end

  add_index "pages", ["ledger_id"], name: "index_pages_on_ledger_id", using: :btree
  add_index "pages", ["pagetype_id"], name: "index_pages_on_pagetype_id", using: :btree
  add_index "pages", ["transcription_id"], name: "index_pages_on_transcription_id", using: :btree

  create_table "pagetypes", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "ledger_id",    limit: 4
    t.float    "default_zoom", limit: 24
    t.string   "description",  limit: 255
  end

  add_index "pagetypes", ["ledger_id"], name: "index_asset_collections_on_collection_group_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "album_id",            limit: 4
    t.string   "name",                limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "upload_file_name",    limit: 255
    t.string   "upload_content_type", limit: 255
    t.integer  "upload_file_size",    limit: 4
    t.datetime "upload_updated_at"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree

  create_table "transcriptions", force: :cascade do |t|
    t.text     "page_data",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",    limit: 4
    t.integer  "asset_id",   limit: 4
  end

  add_index "transcriptions", ["asset_id"], name: "index_transcriptions_on_asset_id", using: :btree
  add_index "transcriptions", ["user_id"], name: "index_transcriptions_on_user_id", using: :btree

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
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "name",                   limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.boolean  "admin",                  limit: 1
    t.text     "about",                  limit: 65535
    t.integer  "contributions",          limit: 4
    t.string   "rank",                   limit: 255
    t.integer  "asset_id",               limit: 4
    t.integer  "transcription_id",       limit: 4
  end

  add_index "users", ["asset_id"], name: "index_users_on_asset_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["transcription_id"], name: "index_users_on_transcription_id", using: :btree

end
