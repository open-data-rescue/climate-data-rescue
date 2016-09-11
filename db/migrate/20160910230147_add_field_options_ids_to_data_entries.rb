class AddFieldOptionsIdsToDataEntries < ActiveRecord::Migration
  def change
    remove_column :data_entries, :field_option_id, :string
    add_column :data_entries, :field_options_ids, :string
  end
end
