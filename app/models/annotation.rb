class Annotation < ApplicationRecord
  has_many :data_entries, dependent: :destroy
  belongs_to :transcription, touch: true
  belongs_to :field_group
  belongs_to :page
  # belongs_to :user # not yet, but needs to be added

  validates :date_time_id,
            presence: true
  validates :observation_date,
            presence: true

  def self.order_by_date(direction='asc')
    order("observation_date #{direction}")
  end

  def self.without_dimensions
    where(
      x_tl: nil,
      y_tl: nil,
      width: nil,
      height: nil
    )
  end

  def self.with_dimensions
    where.not(
      x_tl: nil,
      y_tl: nil,
      width: nil,
      height: nil
    )
  end
  
end
