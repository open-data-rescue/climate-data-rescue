class AddDismissedBoxTutorialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dismissed_box_tutorial, :boolean, null:false, default: false
  end
end
