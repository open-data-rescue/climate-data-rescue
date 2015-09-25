class AddUploadToAsset < ActiveRecord::Migration
  def change
  	add_column :assets, :pagetype_id, :integer
  	add_index :assets, :pagetype_id

  end
  def self.up
    add_attachment :assets, :upload
  end

  def self.down
    remove_attachment :assets, :upload
  end

end
