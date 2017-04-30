class Annotation < ActiveRecord::Base
  #attr_accessible :bounds, :data, :transcription_id, :fieldgroup_id, :page_id
  belongs_to :transcription
  has_many :data_entries, dependent: :destroy
  belongs_to :field_group

  after_save :touch_associations
  def touch_associations
    transcription.touch
    transcription.save!
  end

  def self.order_by_date direction='asc'
    order('observation_date #{direction}')
  end
  
end
