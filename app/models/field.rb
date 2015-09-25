class Field < ActiveRecord::Base
  attr_accessible :field_key, :initial_value, :kind, :name, :options, :validations
  belongs_to :fieldgroup
end
