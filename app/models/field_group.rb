class FieldGroup < ActiveRecord::Base
  #attr_accessible :bounds, :description, :height, :help, :name, :resizable, :width, :zoom
  has_and_belongs_to_many :fields
  has_many :annotations
  belongs_to :page_type


  def presentation_name
    if display_name && display_name.present?
      display_name
    else
      name
    end
  end
end
