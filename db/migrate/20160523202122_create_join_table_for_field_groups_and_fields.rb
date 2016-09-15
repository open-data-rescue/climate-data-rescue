class CreateJoinTableForFieldGroupsAndFields < ActiveRecord::Migration
  def change
    create_join_table :field_groups, :fields do |t|
      t.index :field_group_id
      t.index :field_id
    end
  end
end
