class Field < ActiveRecord::Base
  has_and_belongs_to_many :field_groups
  has_and_belongs_to_many :field_options
  default_scope { order(position: :asc) }
end
