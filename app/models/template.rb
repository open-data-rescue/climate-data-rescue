class Template < ActiveRecord::Base
  attr_accessible :default_zoom, :description, :name, :project
  
  has_many :assets
  has_many :entities
  belongs_to :asset
end
