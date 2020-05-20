# This migration comes from better_together (originally 20190325000336)
class CreateBetterTogetherIdentifications < ActiveRecord::Migration[5.2]
  def change
    create_table :better_together_identifications do |t|
      t.boolean :active,
                  index: {
                    name: 'by_active_state'
                  },
                  null: false
      t.references :identity,
                  polymorphic: true,
                  index: {
                    name: 'by_identity'
                  },
                  null: false
      t.references :agent,
                  polymorphic: true,
                  index: {
                    name: 'by_agent'
                  },
                  null: false
      t.string :bt_id,
               limit: 100,
               index: {
                 name: 'identification_by_bt_id',
                 unique: true
               },
               null: false

      t.integer :lock_version, null: false, default: 0
      t.timestamps null: false

      t.index %i(identity_type identity_id agent_type agent_id),
              unique: true,
              name: 'unique_identification'

      t.index %i(active agent_type agent_id),
              unique: true,
              name: 'active_identification'
    end
  end
end
