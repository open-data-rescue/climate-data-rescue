class UpdatePageTypesFieldGroupsSortOrderDefault < ActiveRecord::Migration
  def change
    change_column_default :page_types_field_groups, :sort_order, from: nil, to: 0

    change_column_default :field_groups_fields, :sort_order, from: nil, to: 0
  end
end
