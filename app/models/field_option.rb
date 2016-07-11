class FieldOption < ActiveRecord::Base
  has_and_belongs_to_many :fields
  has_many :data_entries

  has_attached_file :image,
                  styles: { 
                    icon: ["16x16#", :png],
                    med: ["32x32", :png],
                    large: ["100x100#", :png]
                  },
                  default_style: :icon,
                  url: "/system/:attachment/:style/:hash.:extension",
                  hash_secret: "SECRET"
  validates_attachment :image,
                     content_type: { content_type: ["image/jpg","image/jpeg", "image/png"] }
end
