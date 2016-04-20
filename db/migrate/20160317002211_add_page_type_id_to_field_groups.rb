class AddPageTypeIdToFieldGroups < ActiveRecord::Migration
  def change
    add_column :field_groups, :page_type_id, :integer
  end
end
