class Page < ActiveRecord::Base
  #attr_accessible :classification_count, :display_width, :done, :ext_ref, :height, :order, :width, :pagetype_id, :upload, :name
  belongs_to :pagetype
  has_many :transcriptions

  #handles the image uplaod association
  has_attached_file :upload, :styles =>  
                  { :thumb => "100x100>",
                    :medium => "300x300"}, 
                  :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/
  after_create :set_name_to_filename
  
  # after_create :parse_filename
  def parse_filename
    if self.upload.present?
      filename = self.upload_file_name
      components = filename.split("_")
      self.from_date = Date.parse(components[4])
      
      self.save
    end
  end
  
  #sets the name attribute to the filename of the attached image
  def set_name_to_filename
    if self.upload.present?
      self.name = self.upload_file_name
      self.save
    end
  end
  #sets the height and width attributes of the asset to those of its attachment dimensions on update
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
  #sets the height and width attributes of the asset to those of its attachment dimensions on create
  def extract_upload_dimensions
    return unless upload?
    
    tempfile = upload.queued_for_write[:original]
    
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.width = geometry.width.to_i
      self.height = geometry.height.to_i
      self.save
    end
  end
  #sets a scope for all transcribable pages to be those that are not done
  scope :transcribeable, -> { where(done: false) }

  
  #constant that determines the # of transcriptions an asset must have to be marked done
  CLASSIFICATION_COUNT = 5

  def classification_limit
    5
  end

  # Don't want the image to be squashed
  def display_height
    disp_height = (1.0 * self.display_width / self.width) * self.height
    return disp_height.to_i
  end
  #on new transcription creation, increment the classification count of its associated asset
  def increment_classification_count
    count = self.classification_count.nil? ? 0 : self.classification_count
    count += 1
    self.classification_count = count
    if self.classification_count == CLASSIFICATION_COUNT
      self.done = true
    end
    self.save
  end

end
