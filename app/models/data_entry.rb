class DataEntry < ActiveRecord::Base
	belongs_to :page
	belongs_to :user
	belongs_to :annotation, touch: true
	belongs_to :field

end