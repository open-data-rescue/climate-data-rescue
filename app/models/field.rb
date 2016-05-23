class Field < ActiveRecord::Base
  has_and_belongs_to_many :field_groups
  default_scope { order(position: :asc) }
end
