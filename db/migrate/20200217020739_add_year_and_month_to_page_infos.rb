class AddYearAndMonthToPageInfos < ActiveRecord::Migration[5.2]
  def change
    add_column :page_infos, :month, :integer
    add_column :page_infos, :year, :integer
  end
end
