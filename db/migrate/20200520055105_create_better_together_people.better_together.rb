# This migration comes from better_together (originally 20190216205634)
class CreateBetterTogetherPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :better_together_people do |t|
      t.string :bt_id,
               limit: 100,
               index: {
                 name: 'person_by_bt_id',
                 unique: true
               },
               null: false
      t.string :name,
               null: false,
               limit: 50,
               index: {
                name: 'by_name'
               }
      t.string :description

      t.integer :lock_version, null: false, default: 0
      t.timestamps null: false
    end
  end
end
