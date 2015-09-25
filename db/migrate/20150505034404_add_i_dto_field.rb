class AddIDtoField < ActiveRecord::Migration
  def change
  	add_column :fields, :fieldgroups_id, :integer
  	add_index :fields, :fieldgroups_id
  	add_column :fieldgroups, :template_id, :integer
  	add_index :fieldgroups, :template_id

  end
end
