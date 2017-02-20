class Transcription < ActiveRecord::Base
  #attributes that can be called on the model object
  #attr_accessible :page_data
  belongs_to :page
  has_one :page_type, through: :page
  has_many :field_groups, through: :page_type
  has_many :fields, through: :field_groups
  belongs_to :user
  has_many :annotations, dependent: :destroy
  

  #increments classification count of its related page. Called from the controller.
  def update_classification_count
    @page.increment_classification_count
  end
  
end
