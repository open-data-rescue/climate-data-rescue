class Transcription < ActiveRecord::Base
  #attributes that can be called on the model object
  #attr_accessible :page_data
  belongs_to :page
  belongs_to :user
  has_many :annotations
  

  #increments classification count of its related page. Called from the controller.
  def update_classification_count
    @page.increment_classification_count
  end
  
end
