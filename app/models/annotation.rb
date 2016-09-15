class Annotation < ActiveRecord::Base
  #attr_accessible :bounds, :data, :transcription_id, :fieldgroup_id, :page_id
  belongs_to :transcription
  has_many :data_entries, dependent: :destroy
  belongs_to :field_group
  
  #TODO: make another data type to hold the join and the data, AnnotationData or something
end
