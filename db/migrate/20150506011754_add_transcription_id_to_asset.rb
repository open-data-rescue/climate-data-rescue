class AddTranscriptionIdToAsset < ActiveRecord::Migration
  def change
  	add_column :assets, :transcription_id, :integer
  	add_index :assets, :transcription_id
  end
end
