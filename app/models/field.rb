class Field < ActiveRecord::Base
  translates :name, :full_name, :help,
             fallbacks_for_empty_translations: true,
             touch: true
  globalize_accessors

  has_many :field_groups, through: :field_groups_fields
  has_many :field_groups_fields, dependent: :destroy

  has_many :page_types, through: :field_groups
  
  has_many :field_options, -> { order("field_options_fields.sort_order asc") }, through: :field_options_fields
  has_many :field_options_fields, dependent: :destroy
  has_many :data_entries

  validates :name,
            presence: true
  validates :full_name,
            presence: true
  validates :help,
            presence: true
  validates :field_key,
            presence: true
  validates :data_type,
            presence: true,
            inclusion: {
              in: %w(string integer decimal)
            }

  before_destroy :check_for_data_entries

  private 

  def check_for_data_entries
    if data_entries.any?
      raise "Can't delete a field that has data entered"
    end
  end
  
end
