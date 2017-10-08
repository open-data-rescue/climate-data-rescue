class AddUserPageIndexToTranscriptions < ActiveRecord::Migration
  def change
    add_index :transcriptions, [:user_id, :page_id], unique: true, name: 'user_page'
  end
end
