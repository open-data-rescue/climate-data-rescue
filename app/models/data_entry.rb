class DataEntry < ActiveRecord::Base
	belongs_to :page
	belongs_to :user
	belongs_to :annotation
	belongs_to :field

    after_save :touch_associations
    def touch_associations
      annotation.touch
      annotation.save!
    end

end