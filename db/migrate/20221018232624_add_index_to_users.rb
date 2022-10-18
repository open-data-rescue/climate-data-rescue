class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :data_entries, :user_id
  end
end
