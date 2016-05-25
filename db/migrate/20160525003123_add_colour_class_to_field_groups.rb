class AddColourClassToFieldGroups < ActiveRecord::Migration
  def change
    add_column :field_groups, :colour_class, :string, null:false, default: ""
  end
end
