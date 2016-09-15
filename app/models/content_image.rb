class ContentImage < ActiveRecord::Base

    has_attached_file :image,
                  styles: { 
                    thumb: ["64x64#", :jpg],
                    small: ["200x200>", :jpg],
                    medium: ["400x400>", :jpg],
                    large: ["600x600>", :jpg],
                    xlarge: ["1000x1000>", :jpg]
                  },
                  default_style: :medium,
                  url: "/system/:class/:style/:hash.:extension",
                  hash_secret: "SECRET"
    validates_attachment :image,
                        presence: true,
                        content_type: { content_type: ["image/jpg","image/jpeg", "image/png"] }

    def name
        name = read_attribute(:name)
        image_file_name unless name.present?

        name
    end
end
