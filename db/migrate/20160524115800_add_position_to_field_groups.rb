class AddPositionToFieldGroups < ActiveRecord::Migration
  def change
    add_column :field_groups, :position, :integer, :null => false, :default => 0
  end
end
