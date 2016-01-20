class AddCollectionGroupIdToAssetCollection < ActiveRecord::Migration
  def change
  	add_column :asset_collections, :collection_group_id, :integer
  	add_index :asset_collections, :collection_group_id
  end
end
