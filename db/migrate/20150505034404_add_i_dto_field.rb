class AddIDtoField < ActiveRecord::Migration
  def change
  	add_column :fields, :entity_id, :integer
  	add_index :fields, :entity_id
  	add_column :entities, :template_id, :integer
  	add_index :entities, :template_id

  end
end
