class AddTranscriptionIdAndAssetidToUser < ActiveRecord::Migration
  def change
  	add_column :users, :asset_id, :integer
  	add_index :users, :asset_id
  	add_column :users, :transcription_id, :integer
  	add_index :users, :transcription_id
  end
end
