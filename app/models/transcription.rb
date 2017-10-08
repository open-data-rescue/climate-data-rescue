class Transcription < ActiveRecord::Base
  #attributes that can be called on the model object
  #attr_accessible :page_data
  belongs_to :page
  belongs_to :user
  has_one :page_type, through: :page
  has_many :field_groups, through: :page_type
  has_many :fields, through: :field_groups
  has_many :annotations, dependent: :destroy

  validates :page_id, uniqueness: { scope: :user_id }, presence: true
  validates :user_id, presence: true
  

  def unique_observation_dates
    annotations.select(:observation_date).uniq
  end

  def num_rows_expected
    page.num_rows_expected
  end
  
end
