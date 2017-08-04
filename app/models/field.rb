class Field < ActiveRecord::Base
  has_many :field_groups, through: :field_groups_fields
  has_many :field_groups_fields, dependent: :destroy

  has_many :page_types, through: :field_groups
  
  has_many :field_options, -> { order("field_options_fields.sort_order asc") }, through: :field_options_fields
  has_many :field_options_fields, dependent: :destroy
  has_many :data_entries

  before_destroy :check_for_data_entries

  # alias_attribute :full_name, :display_name

  translates :name, :full_name, :help, fallbacks_for_empty_translations: true, touch: true
  globalize_accessors

  def check_for_data_entries
    if data_entries.any?
      raise "Can't delete a field that has data entered"
    end
  end
  
end
