class AddUploadToAsset < ActiveRecord::Migration
  def change
  	add_column :assets, :asset_collection_id, :integer
  	add_index :assets, :asset_collection_id

  end
  def self.up
    add_attachment :assets, :upload
  end

  def self.down
    remove_attachment :assets, :upload
  end

end
