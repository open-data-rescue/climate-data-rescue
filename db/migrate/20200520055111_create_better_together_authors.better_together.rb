# This migration comes from better_together (originally 20200520035111)
class CreateBetterTogetherAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :better_together_authors do |t|
      t.string :bt_id,
               null: false,
               index: {
                 name: 'author_by_bt_id',
                 unique: true
               },
               limit: 50
      t.references  :author,
                    null: false,
                    polymorphic: true,
                    index: {
                      name: 'by_author',
                      unique: true
                    }

      t.integer :lock_version, null: false, default: 0
      t.timestamps null: false
    end
  end
end
