class Transcription < ActiveRecord::Base
  #attributes that can be called on the model object
  attr_accessible :page_data, :user_id, :asset_collection_id, :asset_id, :user_id
  belongs_to :asset
  belongs_to :user
  belongs_to :asset_collection
  has_many :annotations
  

  #increments classification count of its related asset. Called from the controller.
  def update_classification_count
    @asset.increment_classification_count
  end
  
end
