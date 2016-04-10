class AddFieldGroupIdToAnnotations < ActiveRecord::Migration
  def change
    add_column :annotations, :field_group_id, :integer
  end
end
