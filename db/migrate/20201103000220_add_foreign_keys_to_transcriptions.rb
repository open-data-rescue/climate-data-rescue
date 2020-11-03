class AddForeignKeysToTranscriptions < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :transcriptions, :users
    add_foreign_key :transcriptions, :pages
  end
end
