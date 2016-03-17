class Annotation < ActiveRecord::Base
  #attr_accessible :bounds, :data, :transcription_id, :fieldgroup_id, :page_id
  belongs_to :transcription
  has_and_belongs_to_many :fields, through: :annotations_data
end
