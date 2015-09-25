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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150924231026) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "annotations", :force => true do |t|
    t.text     "bounds"
    t.text     "data"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "transcription_id"
    t.integer  "asset_id"
    t.integer  "fieldgroup_id"
  end

  add_index "annotations", ["asset_id"], :name => "index_annotations_on_asset_id"
  add_index "annotations", ["fieldgroup_id"], :name => "index_annotations_on_entity_id"
  add_index "annotations", ["transcription_id"], :name => "index_annotations_on_transcription_id"

  create_table "assets", :force => true do |t|
    t.integer  "height"
    t.integer  "width"
    t.integer  "display_width"
    t.string   "ext_ref"
    t.integer  "order"
    t.integer  "template_id"
    t.boolean  "done"
    t.integer  "classification_count", :default => 0, :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "pagetype_id"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.integer  "transcription_id"
    t.string   "name"
  end

  add_index "assets", ["pagetype_id"], :name => "index_assets_on_asset_collection_id"
  add_index "assets", ["template_id"], :name => "index_assets_on_template_id"
  add_index "assets", ["transcription_id"], :name => "index_assets_on_transcription_id"

  create_table "fieldgroups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "help"
    t.boolean  "resizable"
    t.integer  "width"
    t.integer  "height"
    t.text     "bounds"
    t.float    "zoom"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "template_id"
  end

  add_index "fieldgroups", ["template_id"], :name => "index_entities_on_template_id"

  create_table "fields", :force => true do |t|
    t.string   "name"
    t.string   "field_key"
    t.string   "kind"
    t.string   "initial_value"
    t.text     "options"
    t.text     "validations"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "fieldgroup_id"
  end

  add_index "fields", ["fieldgroup_id"], :name => "index_fields_on_entity_id"

  create_table "ledgers", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "extern_ref"
    t.integer  "pagetype_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "ledgers", ["pagetype_id"], :name => "index_collection_groups_on_asset_collection_id"

  create_table "pagetypes", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "extern_ref"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "pagetype_id"
    t.integer  "ledger_id"
  end

  add_index "pagetypes", ["ledger_id"], :name => "index_asset_collections_on_collection_group_id"
  add_index "pagetypes", ["pagetype_id"], :name => "index_asset_collections_on_collectionID"

  create_table "photos", :force => true do |t|
    t.integer  "album_id"
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  add_index "photos", ["album_id"], :name => "index_photos_on_album_id"

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "project"
    t.float    "default_zoom"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "transcriptions", :force => true do |t|
    t.text     "page_data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "asset_id"
  end

  add_index "transcriptions", ["asset_id"], :name => "index_transcriptions_on_asset_id"
  add_index "transcriptions", ["user_id"], :name => "index_transcriptions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin"
    t.text     "about"
    t.integer  "contributions"
    t.string   "rank"
    t.integer  "asset_id"
    t.integer  "transcription_id"
  end

  add_index "users", ["asset_id"], :name => "index_users_on_asset_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["transcription_id"], :name => "index_users_on_transcription_id"

end
