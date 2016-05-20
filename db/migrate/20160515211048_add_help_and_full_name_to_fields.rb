class AddHelpAndFullNameToFields < ActiveRecord::Migration
  def change
    add_column :fields, :full_name, :string
    add_column :fields, :help, :text
  end
end
