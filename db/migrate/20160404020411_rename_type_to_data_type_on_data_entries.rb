class RenameTypeToDataTypeOnDataEntries < ActiveRecord::Migration
  def change
    rename_column :data_entries, :type, :data_type
  end
end
