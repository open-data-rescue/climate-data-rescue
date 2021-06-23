class ChangeDataEntryValueFromStringToText < ActiveRecord::Migration[5.2]
  def up
    change_column :data_entries, :value, :text
  end

  def down
    change_column :data_entries, :value, :string
  end
end
