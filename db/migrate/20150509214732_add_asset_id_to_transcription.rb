class AddAssetIdToTranscription < ActiveRecord::Migration
  def change
  	add_column :transcriptions, :asset_id, :integer
  	add_index :transcriptions, :asset_id
  end
end
