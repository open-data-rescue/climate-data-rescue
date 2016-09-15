class CreateJoinTableForPageTypesAndFieldGroups < ActiveRecord::Migration
  def change
    create_join_table :page_types, :field_groups do |t|
      t.index :page_type_id
      t.index :field_group_id
    end
  end
end
