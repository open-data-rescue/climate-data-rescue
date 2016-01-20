class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :height
      t.integer :width
      t.integer :display_width
      t.string :ext_ref
      t.integer :order
      t.integer :template_id
      t.boolean :done
      t.integer :classification_count, :null => false, :default => 0

      t.timestamps
    end
    add_index :assets, :template_id
  end
end
