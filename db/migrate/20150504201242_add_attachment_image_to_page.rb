class AddAttachmentImageToPage < ActiveRecord::Migration
  
  def self.up
    add_attachment :pages, :image
  end

  def self.down
    remove_attachment :pages, :image
  end

end
