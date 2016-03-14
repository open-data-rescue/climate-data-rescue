class FieldGroup < ActiveRecord::Base
  #attr_accessible :bounds, :description, :height, :help, :name, :resizable, :width, :zoom
  has_many :fields
  has_many :annotations
  belongs_to :page_type

end
