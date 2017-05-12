class AddVisibleToPageTypes < ActiveRecord::Migration
  def change
    add_column :page_types, :visible, :boolean, default: false, nil: false
  end
end
