class RenamePositionColumnsOnAnnotations < ActiveRecord::Migration
  def change
    rename_column :annotations, :top, :x_tl
    rename_column :annotations, :right, :y_tl
    rename_column :annotations, :bottom, :x_br
    rename_column :annotations, :left, :y_br
  end
end
