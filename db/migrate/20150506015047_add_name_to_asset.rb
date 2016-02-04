class AddNameToAsset < ActiveRecord::Migration
  def change
  	add_column :assets, :name, :string
  end
end
