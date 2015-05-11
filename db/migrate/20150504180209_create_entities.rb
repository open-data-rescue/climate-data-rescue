class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name
      t.string :description
      t.string :help
      t.boolean :resizable
      t.integer :width
      t.integer :height
      t.text :bounds
      t.float :zoom

      t.timestamps
    end
  end
end
