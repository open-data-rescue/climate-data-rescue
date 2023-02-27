class AddDataEntryVersions < ActiveRecord::Migration[6.1]
  TEXT_BYTES = 1_073_741_823

  def change
    create_table :audit_data_entry_versions, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" do |t|
      t.string   :item_type, { null: false }
      t.bigint   :item_id,   null: false
      t.string   :event,     null: false
      t.string   :whodunnit
      t.text     :object, limit: TEXT_BYTES
      t.text     :object_changes, limit: TEXT_BYTES
      t.datetime :created_at, limit: 6

      t.virtual :whodunnit_as_id, type: :integer, as: "CAST(whodunnit as UNSIGNED)", stored: true

      # These will use the meta information
      t.text :value
      t.text :prev_value
      t.integer :user_id
      t.integer :prev_user_id
      t.text :notes
    end
    add_index :audit_data_entry_versions, %i(item_type item_id)
  end
end
