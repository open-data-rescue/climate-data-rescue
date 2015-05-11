class Annotation < ActiveRecord::Base
  attr_accessible :bounds, :data, :transcription_id, :entity_id, :asset_id
  belongs_to :transcription
  belongs_to :entity
  belongs_to :asset
end
