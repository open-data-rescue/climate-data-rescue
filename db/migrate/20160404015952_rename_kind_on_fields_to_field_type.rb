class RenameKindOnFieldsToFieldType < ActiveRecord::Migration
  def change
    rename_column :fields, :kind, :html_field_type
  end
end
