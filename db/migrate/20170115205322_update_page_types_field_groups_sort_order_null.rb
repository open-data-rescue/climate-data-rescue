class UpdatePageTypesFieldGroupsSortOrderNull < ActiveRecord::Migration
  def change
    change_column_null :page_types_field_groups, :sort_order, false, 0
    change_column_null :field_groups_fields, :sort_order, false, 0
  end
end
