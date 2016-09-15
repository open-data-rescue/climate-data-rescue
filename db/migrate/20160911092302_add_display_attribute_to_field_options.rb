class AddDisplayAttributeToFieldOptions < ActiveRecord::Migration
  def change
    add_column :field_options, :display_attribute, :string, default: "name", nil: false
  end
end
