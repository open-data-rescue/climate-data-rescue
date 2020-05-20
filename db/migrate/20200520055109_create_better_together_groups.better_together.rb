# This migration comes from better_together (originally 20200115231812)
class CreateBetterTogetherGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :better_together_groups do |t|
      t.string :bt_id,
               null: false,
               index: {
                 name: 'group_by_bt_id',
                 unique: true
               },
               limit: 50
      t.references :creator,
                    index: {
                      name: 'by_creator'
                    },
                    null: false
      t.string :group_privacy,
                index: {
                  name: 'by_group_privacy'
                },
                null: false,
                default: :public

      t.integer :lock_version, default: 0, null: false
      t.timestamps
    end

    add_foreign_key :better_together_groups,
                    :better_together_people,
                    column: :creator_id

  end
end
