class ChangePositionFieldsOnAnnotations < ActiveRecord::Migration
  def change
  	rename_column :annotations, :x_br, :width
  	rename_column :annotations, :y_br, :height
  end
end
