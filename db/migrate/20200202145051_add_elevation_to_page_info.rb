class AddElevationToPageInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :page_infos, :elevation, :string
  end
end
