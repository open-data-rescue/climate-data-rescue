class AddAttachmentUploadToAssets < ActiveRecord::Migration
  def self.up
    change_table :assets do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :assets, :upload
  end
end
