class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :height
      t.integer :width
      t.integer :display_width
      t.string :ext_ref
      t.integer :order
      t.text :template_id
      t.boolean :done
      t.integer :classification_count

      t.timestamps
    end
  end
end
