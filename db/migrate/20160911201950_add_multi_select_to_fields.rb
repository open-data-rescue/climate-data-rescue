class AddMultiSelectToFields < ActiveRecord::Migration
  def change
    add_column :fields, :multi_select, :boolean, default: false, nil: false
  end
end
