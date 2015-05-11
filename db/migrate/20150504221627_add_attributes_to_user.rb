class AddAttributesToUser < ActiveRecord::Migration
  def change
  	add_column :users, :about, :text
  	add_column :users, :contributions, :integer
  	add_column :users, :rank, :string
  end
end
