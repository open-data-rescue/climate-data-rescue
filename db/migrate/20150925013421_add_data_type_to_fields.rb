class AddDataTypeToFields < ActiveRecord::Migration
  def change
    add_column :fields, :data_type, :string
  end
end
