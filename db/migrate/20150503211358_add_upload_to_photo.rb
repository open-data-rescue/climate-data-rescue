class AddUploadToPhoto < ActiveRecord::Migration
  def self.up
    add_attachment :photos, :upload
  end

  def self.down
    remove_attachment :photos, :upload
  end
end