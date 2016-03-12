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
      t.string :ledger_type
      t.string :ledger_volume
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
    add_index :pages, :page_type_id
    add_index :pages, :ledger_type
  end
end
