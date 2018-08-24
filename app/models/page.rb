class Page < ActiveRecord::Base
  belongs_to :page_type
  belongs_to :transcriber, class_name: "User"

  has_many :field_groups, through: :page_type
  has_many :fields, through: :field_groups
  has_many :transcriptions, dependent: :destroy  
  has_many :page_days, dependent: :destroy
  has_many :data_entries, dependent: :destroy

  #handles the image upload association
  has_attached_file :image,
                  styles: { 
                    thumb: ["64x64#", :jpg],
                    small: ["200x200>", :jpg],
                    medium: ["400x400>", :jpg],
                    large: ["600x600>", :jpg],
                    xlarge: ["1000x1000>", :jpg]
                  },
                  default_style: :medium,
                  url: "/system/:attachment/:style/:hash.:extension",
                  hash_secret: "SECRET"
  validates_attachment :image,
                     content_type: { content_type: ["image/jpg","image/jpeg", "image/png"] }

  before_save :extract_upload_dimensions
  after_create :parse_filename
  before_destroy :check_for_delete
  
  #sets a scope for all transcribable pages to be those that are not done
  scope :transcribeable, -> { 
    joins({:page_type => :field_groups}).
    where(done: false, visible: true, 
      page_types: { visible: true }
    ).uniq.order("pages.start_date asc, page_types.number asc") }

  scope :unseen, -> (user) {
    if user && user.pages.any?
      where("pages.id not in (?)", user.pages.pluck(:id))
    end
  }

  def has_metadata?
    page_days.any?
  end

  def num_rows_expected
    if page_days.any?
      total = page_days.sum(:num_observations)
      total
    else
      nil
    end
  end
  
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
  
  #sets the height and width attributes of the page to those of its attachment dimensions on update
  def extract_dimensions
    return unless self.image?
    #regex to select all parts of the filename preceding the end of the supported file types and forms
    reg = /(.+\.(jpg|JPG|jpeg|JPEG|png|PNG))/
    tempfile = self.image.url
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

  private 

  def check_for_delete
    if data_entries.any? 
      raise I18n.t('cant-delete-page-that-has-been-transcribed')
    end
  end
  
  def parse_filename
    Page.transaction do
      # begin
        if image.present?
          filename = image_file_name
          components = filename.split("_")
          if components.count == 6
            self.accession_number = components[0]
            if components[1] && components[2]
              ledger_type = components[1]
              volume = components[2]
              ledger = Ledger.find_by(ledger_type: ledger_type)
              unless ledger
                ledger = Ledger.create!(title: ledger_type, ledger_type: ledger_type)
              end
            end
            self.volume = volume
            self.start_date = Date.parse(components[3])
            self.end_date = Date.parse(components[4])
            
            self.title = components[3] + " to " + components[4]
            
            
            if components[5] && components[5].length > 0
              page_type_num = components[5][0]
              page_type = PageType.find_by(number: page_type_num, ledger_id: ledger.id)
              unless page_type
                page_type = PageType.create!(number: page_type_num, ledger_type: ledger_type, ledger_id: ledger.id, title: ('Register ' + ledger_type + ', page ' + page_type_num))
              end
              self.page_type_id = page_type.id
            end
          else
            raise "invalid filename"
          end
          
          self.save!
        end
      # rescue => e
        
      # end
      
    end
  end
  
  #sets the height and width attributes of the page to those of its attachment dimensions on create
  def extract_upload_dimensions
    return unless image?
    
    tempfile = image.queued_for_write[:original]
    
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.width = geometry.width.to_i
      self.height = geometry.height.to_i
      # self.save
    end
  end

end
