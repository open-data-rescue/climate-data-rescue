class Transcription < ActiveRecord::Base
  #attributes that can be called on the model object
  #attr_accessible :page_data
  belongs_to :page
  has_one :page_type, through: :page
  has_many :field_groups, through: :page_type
  has_many :fields, through: :field_groups
  belongs_to :user
  has_many :annotations, dependent: :destroy
  

  def unique_observation_dates
    annotations.collect{|a| a.observation_date}.uniq
  end

  def num_rows_expected
    page.num_rows_expected
  end
  
end
