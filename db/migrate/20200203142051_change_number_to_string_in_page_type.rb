class ChangeNumberToStringInPageType < ActiveRecord::Migration[5.2]
  def change
	  change_column :page_types, :number, :string
  end
end
