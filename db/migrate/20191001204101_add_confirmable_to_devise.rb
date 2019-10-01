class AddConfirmableToDevise < ActiveRecord::Migration[5.2]
  def up
    # users as confirmed, do the following
    User.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
  end
end
