class Page < ActiveRecord::Base
  #attr_accessible :classification_count, :display_width, :done, :ext_ref, :height, :order, :width, :pagetype_id, :upload, :name
  belongs_to :pagetype
  has_many :transcriptions

  #handles the image upload association
  has_attached_file :image, :styles =>  
                  { :thumb => "100x100>",
                    :medium => "300x300"}, 
                  :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :presence => true, :content_type => /\Aimage\/.*\Z/
  before_save :extract_upload_dimensions
  # after_create :parse_filename
  
  def to_jq_upload
      {
        "name" => read_attribute(:image_file_name),
        "size" => image.size,
        "url" => image.url,
        "thumbnailUrl" => image.url(:thumb),
        "deleteUrl" => "/pages/#{self.id}",
        "deleteType" => "DELETE",
        "pageId" => "page-#{self.id}"
      }
  end
  
  # after_create :parse_filename
  # def parse_filename
    # Page.transaction do
      # begin
        # if self.image.present?
          # filename = self.image_file_name
          # components = filename.split("_")
          # unless components.count == 6
            # raise "invalid filename"
          # end
          # self.accession_number = components[0]
          # if components[1].length == 1
            # self.ledger_type = components[1]
            # ledger = Ledger.find_by(type: components[1])
            # if ledger
#               
            # end
          # else  
            # raise "invalid filename"
          # end
          # self.ledger_volume = components[2]
          # self.from_date = Date.parse(components[3])
          # self.to_date = Date.parse(components[4])
#           
          # #TODO: Check that the heck this part of the filename means.
          # self.page_number = components[5]
          # self.save!
        # end
      # rescue => e
#         
      # end
#       
    # end
  # end
  
  
  #sets the height and width attributes of the page to those of its attachment dimensions on update
  def extract_dimensions
    return unless self.upload?
    #regex to select all parts of the filename preceding the end of the supported file types and forms
    reg = /(.+\.(jpg|JPG|jpeg|JPEG|png|PNG))/
    tempfile = self.upload.url
    puts tempfile
    cleaned = reg.match(tempfile).to_s
    puts cleaned
    full_path = Rails.root.to_s + "/public" + cleaned
    puts full_path
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(full_path)
      self.width = geometry.width.to_i
      self.height = geometry.height.to_i
      self.save
    end
  end
  #sets the height and width attributes of the page to those of its attachment dimensions on create
  def extract_upload_dimensions
    return unless upload?
    
    tempfile = upload.queued_for_write[:original]
    
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.width = geometry.width.to_i
      self.height = geometry.height.to_i
      # self.save
    end
  end
  #sets a scope for all transcribable pages to be those that are not done
  scope :transcribeable, -> { where(done: false) }

  
  #constant that determines the # of transcriptions an page must have to be marked done
  CLASSIFICATION_COUNT = 5

  # def classification_limit
    # 5
  # end

  
  #on new transcription creation, increment the classification count of its associated page
  def increment_classification_count
    self.classification_count += 1
    if self.classification_count == CLASSIFICATION_COUNT
      self.done = true
    end
    self.save
  end

end
