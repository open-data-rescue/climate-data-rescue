class RemovePositionFromFieldOptions < ActiveRecord::Migration
  def change
    remove_column :field_options, :position
  end
end
