class Annotation < ActiveRecord::Base
  #attr_accessible :bounds, :data, :transcription_id, :fieldgroup_id, :page_id
  belongs_to :transcription
  has_and_belongs_to_many :fields, through: :annotations_data
  
  #TODO: make another data type to hold the join and the data, AnnotationData or something
end
