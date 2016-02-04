class CreateTranscriptions < ActiveRecord::Migration
  def change
    create_table :transcriptions do |t|
      t.text :page_data

      t.timestamps
    end
  end
end
