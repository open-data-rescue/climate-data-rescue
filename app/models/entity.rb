class Entity < ActiveRecord::Base
  attr_accessible :bounds, :description, :height, :help, :name, :resizable, :width, :zoom, :template_id
  has_many :fields
  has_many :annotations
  belongs_to :template

end
