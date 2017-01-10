class FieldGroup < ActiveRecord::Base
  
  has_many :fields, -> { order("field_groups_fields.sort_order asc") }, through: :field_groups_fields
  has_many :field_groups_fields, dependent: :destroy
  has_many :annotations
  has_many :page_types

  def presentation_name
    if display_name && display_name.present?
      display_name
    else
      name
    end
  end
end
