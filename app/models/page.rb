class Page < ApplicationRecord
  STALE_DURATION = ENV.fetch("STALE_DURATION_WEEKS", 2).to_i.weeks.freeze

  belongs_to :page_type

  has_many :field_groups, through: :page_type
  has_many :fields, through: :field_groups
  has_many :transcriptions, dependent: :destroy, autosave: true
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
  before_destroy :check_for_delete

  #sets a scope for all transcribable pages to be those that are not done
  scope :transcribeable, -> {
    joins(page_type: {
      field_groups: :fields
    }).
    where(
      done: false,
      visible: true,
      page_types: { visible: true }
    ).inactive.order("pages.start_date asc, page_types.number asc").distinct
  }

  scope :unseen, -> (user) {
    if user && user.pages.any?
      where("pages.id not in (?)", user.pages.pluck(:id))
    end
  }

  scope :inactive, -> {
    stale_date = Date.current - STALE_DURATION
    pages = self.arel_table
    transcriptions = Transcription.arel_table

    active_uncompleted = transcriptions[:updated_at].gteq(stale_date).and(
      transcriptions[:complete].eq(false)
    )
    completed = transcriptions[:complete].eq(true)

    condition = active_uncompleted.or(completed)

    page_ids = transcriptions.where(condition).project(:page_id)

    where(pages[:id].not_in(page_ids))
  }

  def has_metadata?
    page_days.any?
  end

  def num_rows_expected
    if page_days.any?
      page_days.sum(:num_observations)
    else
      0
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
    # puts tempfile
    cleaned = reg.match(tempfile).to_s
    # puts cleaned
    full_path = Rails.root.to_s + "/public" + cleaned
    # puts full_path
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
      errors.add(:base, I18n.t('cant-delete-page-that-has-been-transcribed'))
      throw(:abort)
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
    end
  end

end
