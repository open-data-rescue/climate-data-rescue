class AddVisibleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :visible, :boolean, default: true, nil: false
  end
end
