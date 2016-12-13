class Field < ActiveRecord::Base
  has_many :field_groups, through: :field_groups_fields
  has_many :field_groups_fields, dependent: :destroy
  
  has_many :field_options, -> { order("field_options_fields.sort_order asc") }, through: :field_options_fields
  has_many :field_options_fields, dependent: :destroy
  has_many :data_entries
  
  default_scope { order(position: :asc) }
end
