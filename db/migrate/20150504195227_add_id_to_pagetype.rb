class AddIdToPagetype < ActiveRecord::Migration
  def change
  	add_column :pagetypes, :pagetype_id, :integer
  	add_index :pagetypes, :pagetype_id
  end
end
