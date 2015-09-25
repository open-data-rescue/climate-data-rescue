class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.string :title
      t.string :author
      t.string :extern_ref
      t.integer :pagetype_id
      t.timestamps
    end
    add_index "ledgers", ["pagetype_id"], :name => "index_ledgers_on_pagetype_id"
  end
end
