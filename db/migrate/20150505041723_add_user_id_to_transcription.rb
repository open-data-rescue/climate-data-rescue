class AddUserIdToTranscription < ActiveRecord::Migration
  def change
  	add_column :transcriptions, :user_id, :integer
  	add_index :transcriptions, :user_id
  end
end
