class ChangePageTypeNumberFromIntegerToString < ActiveRecord::Migration[5.2]
  def up
    change_column :page_types, :number, :string
  end

  def down
    change_column :page_types, :number, :integer
  end
end
