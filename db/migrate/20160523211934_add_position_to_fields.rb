class AddPositionToFields < ActiveRecord::Migration
  def change
    add_column :fields, :position, :integer, null: false, default: 0
  end
end
