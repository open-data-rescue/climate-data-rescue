# This migration comes from better_together (originally 20190301040948)
class CreateBetterTogetherInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :better_together_invitations do |t|
      t.string  :bt_id,
                null: false,
                index: {
                  name: 'invitation_by_bt_id',
                  unique: true
                },
                limit: 100
      t.string  :status,
                limit: 20,
                null: false,
                index: {
                  name: 'by_status'
                }
      t.datetime  :valid_from,
                  null: false,
                  index: {
                    name: 'by_valid_from'
                  }
      t.datetime  :valid_until,
                  index: {
                    name: 'by_valid_until'
                  }
      t.references  :invitable,
                    null: false,
                    polymorphic: true,
                    index: {
                      name: 'by_invitable'
                    }
      t.references  :inviter,
                    null: false,
                    polymorphic: true,
                    index: {
                      name: 'by_inviter'
                    }
      t.references  :invitee,
                    null: false,
                    polymorphic: true,
                    index: {
                      name: 'by_invitee'
                    }
      t.references  :role,
                    index: {
                      name: 'by_role'
                    }

      t.integer :lock_version, default: 0, null: false
      t.timestamps
    end
  end
end
