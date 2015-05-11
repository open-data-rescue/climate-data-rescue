class AddAssetIdAndEntityIdToAnnotation < ActiveRecord::Migration
  def change
  	add_column :annotations, :asset_id, :integer
  	add_index :annotations, :asset_id
  	add_column :annotations, :entity_id, :integer
  	add_index :annotations, :entity_id
  end
end
