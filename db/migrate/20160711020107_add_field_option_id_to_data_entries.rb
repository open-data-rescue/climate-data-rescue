class AddFieldOptionIdToDataEntries < ActiveRecord::Migration
  def change
    add_column :data_entries, :field_option_id, :integer
  end
end
