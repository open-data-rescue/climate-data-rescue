class ChangeTemplateIdColumnForAsset < ActiveRecord::Migration
  def change
  	remove_column :assets, :template_id, :string
  	add_column :assets, :template_id, :integer
  	add_index :assets, :template_id
  end
end
