class Field < ActiveRecord::Base
  has_and_belongs_to_many :field_groups
  has_many :field_options, through: :field_options_fields
  has_many :field_options_fields, dependent: :destroy
  default_scope { order(position: :asc) }
end
