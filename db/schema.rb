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

ActiveRecord::Schema.define(version: 2023_02_26_161316) do

  create_table "annotations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "x_tl"
    t.integer "y_tl"
    t.integer "width"
    t.integer "height"
    t.integer "page_id"
    t.integer "transcription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "date_time_id"
    t.integer "field_group_id"
    t.datetime "observation_date"
    t.index ["date_time_id"], name: "by_date_time"
    t.index ["field_group_id"], name: "by_field_group"
    t.index ["page_id"], name: "by_page"
    t.index ["transcription_id"], name: "by_transcription"
  end

  create_table "audit_data_entry_versions", charset: "utf8mb4", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", size: :long
    t.text "object_changes", size: :long
    t.datetime "created_at", precision: 6
    t.text "value"
    t.text "prev_value"
    t.integer "user_id"
    t.integer "prev_user_id"
    t.index ["item_type", "item_id"], name: "index_audit_data_entry_versions_on_item_type_and_item_id"
  end

  create_table "better_together_posts", charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "bt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_images", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_entries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "value"
    t.string "data_type"
    t.integer "user_id"
    t.integer "page_id"
    t.integer "annotation_id"
    t.integer "field_id"
    t.string "field_options_ids"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["annotation_id", "field_id"], name: "annotation_field", unique: true
  end

  create_table "field_group_translations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "field_group_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "display_name"
    t.text "help"
    t.index ["field_group_id"], name: "index_field_group_translations_on_field_group_id"
    t.index ["locale"], name: "index_field_group_translations_on_locale"
  end

  create_table "field_groups", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "colour_class", default: "", null: false
    t.string "internal_name"
  end

  create_table "field_groups_fields", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "field_group_id", null: false
    t.integer "field_id", null: false
    t.integer "sort_order", null: false
    t.index ["field_group_id"], name: "index_field_groups_fields_on_field_group_id"
    t.index ["field_id"], name: "index_field_groups_fields_on_field_id"
  end

  create_table "field_option_translations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "field_option_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "help"
    t.index ["field_option_id"], name: "index_field_option_translations_on_field_option_id"
    t.index ["locale"], name: "index_field_option_translations_on_locale"
  end

  create_table "field_options", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text_symbol"
    t.string "display_attribute", default: "name"
    t.string "internal_name"
    t.boolean "is_default", default: false
  end

  create_table "field_options_fields", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "field_option_id", null: false
    t.integer "field_id", null: false
    t.integer "sort_order"
    t.index ["field_id"], name: "index_field_options_fields_on_field_id"
    t.index ["field_option_id"], name: "index_field_options_fields_on_field_option_id"
  end

  create_table "field_translations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "field_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "full_name"
    t.text "help"
    t.index ["field_id"], name: "index_field_translations_on_field_id"
    t.index ["locale"], name: "index_field_translations_on_locale"
  end

  create_table "fields", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "field_key"
    t.string "html_field_type"
    t.string "data_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "multi_select", default: false
    t.string "internal_name"
  end

  create_table "ledgers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "ledger_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_days", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.date "date"
    t.integer "num_observations"
    t.integer "page_id"
    t.integer "user_id"
    t.index ["page_id"], name: "by_page"
    t.index ["user_id"], name: "by_user"
  end

  create_table "page_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "observer"
    t.string "lat"
    t.string "lon"
    t.string "location"
    t.bigint "page_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "elevation"
    t.integer "month"
    t.integer "year"
    t.index ["page_id"], name: "index_page_infos_on_page_id"
    t.index ["user_id"], name: "index_page_infos_on_user_id"
  end

  create_table "page_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "ledger_type"
    t.integer "number"
    t.text "description"
    t.integer "ledger_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "visible", default: false
  end

  create_table "page_types_field_groups", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "page_type_id", null: false
    t.integer "field_group_id", null: false
    t.integer "sort_order", null: false
    t.index ["field_group_id"], name: "index_page_types_field_groups_on_field_group_id"
    t.index ["page_type_id"], name: "index_page_types_field_groups_on_page_type_id"
  end

  create_table "pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.integer "height"
    t.integer "width"
    t.integer "page_type_id"
    t.boolean "done", default: false, null: false
    t.string "accession_number"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "volume"
    t.boolean "visible", default: true
    t.index ["page_type_id"], name: "index_pages_on_page_type_id"
  end

  create_table "sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data", limit: 4294967295
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "static_page_translations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "static_page_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "body", limit: 4294967295
    t.string "slug"
    t.string "meta_keywords"
    t.string "meta_title"
    t.string "meta_description"
    t.index ["locale"], name: "index_static_page_translations_on_locale"
    t.index ["static_page_id"], name: "index_static_page_translations_on_static_page_id"
  end

  create_table "static_pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.boolean "show_in_header", default: false, null: false
    t.boolean "show_in_footer", default: false, null: false
    t.boolean "visible", default: true, null: false
    t.string "foreign_link"
    t.integer "position", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "title_as_header", default: true
    t.integer "parent_id"
    t.boolean "show_in_transcriber", default: false
  end

  create_table "transcriptions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "complete", default: false, null: false
    t.integer "field_groups_fields_count", default: 0, null: false
    t.integer "data_entries_count", default: 0, null: false
    t.integer "started_rows_count", default: 0, null: false
    t.integer "expected_rows_count", default: 0, null: false
    t.integer "field_groups_fields_count", default: 0, null: false
    t.integer "data_entries_count", default: 0, null: false
    t.integer "started_rows_count", default: 0, null: false
    t.integer "expected_rows_count", default: 0, null: false
    t.index ["page_id"], name: "fk_rails_fa14a87e4a"
    t.index ["user_id", "page_id"], name: "user_page", unique: true
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "display_name"
    t.boolean "admin"
    t.text "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean "dismissed_box_tutorial", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", charset: "utf8mb4", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", size: :long
    t.text "object_changes", size: :long
    t.datetime "created_at", precision: 6
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "pages", "page_types"
  add_foreign_key "static_pages", "static_pages", column: "parent_id"
  add_foreign_key "transcriptions", "pages"
  add_foreign_key "transcriptions", "users"
end
