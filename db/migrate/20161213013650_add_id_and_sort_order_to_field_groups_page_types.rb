class AddIdAndSortOrderToFieldGroupsPageTypes < ActiveRecord::Migration
  def change
    add_column :field_groups_page_types, :id, :primary_key
    add_column :field_groups_page_types, :sort_order, :integer, nil: false, default: 0
  end
end
