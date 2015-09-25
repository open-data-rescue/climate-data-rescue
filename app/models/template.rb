class Template < ActiveRecord::Base
  attr_accessible :default_zoom, :description, :name, :project
  
  has_many :assets, :through => :pagetype
  has_many :fieldgroups
  belongs_to :pagetype
end
