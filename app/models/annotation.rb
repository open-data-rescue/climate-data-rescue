class Annotation < ActiveRecord::Base
  #attr_accessible :bounds, :data, :transcription_id, :fieldgroup_id, :page_id
  belongs_to :transcription
  belongs_to :fieldgroup
end
