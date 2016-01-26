class Annotation < ActiveRecord::Base
  #attr_accessible :bounds, :data, :transcription_id, :fieldgroup_id, :asset_id
  belongs_to :transcription
  belongs_to :fieldgroup
end
