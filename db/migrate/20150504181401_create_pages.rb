class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.integer :height
      t.integer :width
      t.integer :order
      t.integer :page_type_id
      t.boolean :done, :null => false, :default => 0
      t.integer :classification_count, :null => false, :default => 0
      t.string :accession_number
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :pages, :page_type_id
  end
end
