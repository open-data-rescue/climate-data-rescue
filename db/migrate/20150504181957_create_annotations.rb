class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :top
      t.integer :right
      t.integer :bottom
      t.integer :left

      t.integer :page_id
      t.integer :transcription_id

      t.timestamps
    end
  end
end
