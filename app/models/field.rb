class Field < ActiveRecord::Base
  #attr_accessible :field_key, :initial_value, :kind, :name, :options, :validations
  belongs_to :field_group
  has_and_belongs_to_many :annotations, through: :annotations_data
end
