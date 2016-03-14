class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.string :field_key
      t.string :kind
      t.string :initial_value
      t.text :options
      t.text :validations
      t.integer :field_group_id
      t.string :data_type

      t.timestamps
    end
  end
end
