class Photo < ActiveRecord::Base
  #attr_accessible :album_id, :name, :upload
  belongs_to :album

  has_attached_file :upload, :styles => { :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/
end
