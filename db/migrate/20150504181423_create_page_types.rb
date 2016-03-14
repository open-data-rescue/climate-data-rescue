class CreatePageTypes < ActiveRecord::Migration
  def change
    create_table :page_types do |t|
      t.string :title
      t.string :ledger_type
      t.integer :number
      t.text :description
      t.integer :ledger_id

      t.timestamps
    end
  end
end
