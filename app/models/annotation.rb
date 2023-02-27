# TODO: Audit
# Put note in the annotation as to what was updated and why
# or we could just put that in the data entry
class Annotation < ApplicationRecord
  has_many :data_entries, dependent: :destroy
  belongs_to :transcription, autosave: true
  belongs_to :field_group
  belongs_to :page, autosave: true
  # belongs_to :user # not yet, but needs to be added

  validates :date_time_id,
            presence: true
  validates :observation_date,
            presence: true
            
  before_save :update_parents

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
  
  def update_parents
    transcription.save!
    page.save!
  end

  def self.with_dimensions
    where.not(
      x_tl: nil,
      y_tl: nil,
      width: nil,
      height: nil
    )
  end

  # This is needed because "autosave" does not update parent on save (only children)
  def update_parents
    transcription.save!
    page.save!
  end

end
