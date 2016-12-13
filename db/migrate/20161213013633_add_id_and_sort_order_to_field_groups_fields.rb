class AddIdAndSortOrderToFieldGroupsFields < ActiveRecord::Migration
  def change
    add_column :field_groups_fields, :id, :primary_key
    add_column :field_groups_fields, :sort_order, :integer
  end
end
