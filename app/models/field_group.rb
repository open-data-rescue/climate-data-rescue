class FieldGroup < ActiveRecord::Base
  
  has_many :fields, -> { order("field_groups_fields.sort_order asc") }, through: :field_groups_fields
  has_many :field_groups_fields, dependent: :destroy
  has_many :annotations

  has_many :page_types, through: :page_types_field_groups
  has_many :page_types_field_groups, dependent: :destroy

  before_destroy :check_for_annotations

  translates :name, :display_name, :help, fallbacks_for_empty_translations: true
  globalize_accessors

  def check_for_annotations
    if annotations.any?
      raise "Can't delete a field group that has user annotations"
    end
  end

  def presentation_name
    if display_name && display_name.present?
      display_name
    else
      name
    end
  end
end
