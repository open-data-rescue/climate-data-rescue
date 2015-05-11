class Field < ActiveRecord::Base
  attr_accessible :field_key, :initial_value, :kind, :name, :options, :validations, :entity_id
  belongs_to :entity
end
