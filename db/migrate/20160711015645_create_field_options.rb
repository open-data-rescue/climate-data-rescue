class CreateFieldOptions < ActiveRecord::Migration
  def change
    create_table :field_options do |t|
      t.string :name
      t.attachment :image
      t.text :help
      t.integer :position
      t.string :value

      t.timestamps null: false
    end
  end
end
