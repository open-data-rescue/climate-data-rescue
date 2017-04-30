class RenameTableFieldGroupsPageTypesToPageTypesFieldGroups < ActiveRecord::Migration
  def change
    rename_table :field_groups_page_types, :page_types_field_groups
  end
end
