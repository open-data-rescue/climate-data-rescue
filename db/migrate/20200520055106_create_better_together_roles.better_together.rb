# This migration comes from better_together (originally 20190224201824)
class CreateBetterTogetherRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :better_together_roles do |t|
      t.string :bt_id,
               null: false,
               index: {
                name: 'role_by_bt_id',
                unique: true
               },
               limit: 50
      t.boolean :reserved,
                null: false,
                default: 0,
                index: {
                  name: 'by_reserved_state'
                }
      t.integer :sort_order,
                index: {
                  name: 'by_sort_order'
                }
      t.string :target_class,
               index: {
                name: 'by_target_class'
               },
               limit: 100

      t.integer :lock_version, default: 0, null: false
      t.timestamps
    end
  end
end
