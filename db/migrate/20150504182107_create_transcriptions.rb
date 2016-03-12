class CreateTranscriptions < ActiveRecord::Migration
  def change
    create_table :transcriptions do |t|
      t.integer :user_id
      t.integer :page_id

      t.timestamps
    end
  end
end
