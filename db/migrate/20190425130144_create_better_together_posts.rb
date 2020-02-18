class CreateBetterTogetherPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :better_together_posts do |t|
      t.string :bt_id

      t.timestamps
    end
  end
end
