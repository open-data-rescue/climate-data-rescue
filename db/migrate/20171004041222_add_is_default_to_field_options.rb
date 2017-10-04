class AddIsDefaultToFieldOptions < ActiveRecord::Migration
  def change
    add_column :field_options, :is_default, :boolean, nil: false, default: false
  end
end
