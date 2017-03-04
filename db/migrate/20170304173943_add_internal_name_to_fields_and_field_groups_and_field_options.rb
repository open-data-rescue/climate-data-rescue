class AddInternalNameToFieldsAndFieldGroupsAndFieldOptions < ActiveRecord::Migration
  def change
    add_column :fields, :internal_name, :string
    add_column :field_groups, :internal_name, :string
    add_column :field_options, :internal_name, :string
  end
end
