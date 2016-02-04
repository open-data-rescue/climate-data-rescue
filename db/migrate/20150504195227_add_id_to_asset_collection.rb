class AddIdToAssetCollection < ActiveRecord::Migration
  def change
  	add_column :asset_collections, :collectionID, :integer
  	add_index :asset_collections, :collectionID
  end
end
