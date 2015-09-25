class AddAssetIdAndFieldgroupIdToAnnotation < ActiveRecord::Migration
  def change
  	add_column :annotations, :asset_id, :integer
  	add_index :annotations, :asset_id
  	add_column :annotations, :fieldgroups_id, :integer
  	add_index :annotations, :fieldgroups_id
  end
end
