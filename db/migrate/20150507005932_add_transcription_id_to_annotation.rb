class AddTranscriptionIdToAnnotation < ActiveRecord::Migration
  def change
  	add_column :annotations, :transcription_id, :integer
  	add_index :annotations, :transcription_id
  end
end
