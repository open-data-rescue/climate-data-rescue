class AddDisplayNameToFieldGroups < ActiveRecord::Migration
  def change
    add_column :field_groups, :display_name, :string
  end
end
