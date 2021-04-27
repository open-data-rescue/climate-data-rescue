class AddMetadataColumnsToFields < ActiveRecord::Migration[5.2]
  def change
    add_column :fields, :period, :string
    add_column :fields, :time_of_day, :string
    add_column :fields, :measurement_type, :string
    add_column :fields, :measurement_unit_original, :string
    add_column :fields, :measurement_unit_si, :string
    add_column :fields, :odr_type, :string
  end
end
