class FieldGroup < ApplicationRecord
  include TranslationHelpers

  translates :name, :display_name, :help,
             fallbacks_for_empty_translations: true,
             touch: true
  globalize_accessors

  has_many :field_groups_fields,
           -> { order("field_groups_fields.sort_order asc") },
           dependent: :destroy
  has_many :fields,
           through: :field_groups_fields
  has_many :annotations

  has_many :page_types_field_groups, dependent: :destroy
  has_many :page_types, through: :page_types_field_groups

  validates :colour_class,
            presence: true,
            inclusion: {
              in: %w(
                red-group pink-group purple-group blue-group cyan-group
                green-group yellow-group orange-group
              )
            }
  validates :name,
            presence: true
  validates :help,
            presence: true

  before_destroy :check_for_annotations

  def presentation_name
    if display_name.present?
      display_name
    else
      name
    end
  end

  private

  def check_for_annotations
    if annotations.any?
      raise "Can't delete a field group that has user annotations"
    end
  end
end
