class CreateDataEntries < ActiveRecord::Migration
  def change
    create_table :data_entries do |t|
      t.string :value
      t.string :type
      t.integer :user_id
      t.integer :page_id
      t.integer :annotation_id
      t.integer :field_id
    end
  end
end
