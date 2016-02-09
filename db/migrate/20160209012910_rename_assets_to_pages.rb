class RenameAssetsToPages < ActiveRecord::Migration
  def change
    rename_table :assets, :pages
  end
end
