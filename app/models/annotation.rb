class Annotation < ActiveRecord::Base
  has_many :data_entries, dependent: :destroy
  belongs_to :transcription, touch: true
  belongs_to :field_group, required: true
  belongs_to :page, required: true
  # belongs_to :user, required: true # not yet, but needs to be added

  validates :date_time_id,
            presence: true
  validates :observation_date,
            presence: true

  def self.order_by_date(direction='asc')
    order("observation_date #{direction}")
  end
  
end
