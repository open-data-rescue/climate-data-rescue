class PageInfo < ApplicationRecord
	 belongs_to :page

   validates :month,
             numericality: {
               only_integer: true,
               greater_than_or_equal_to: 1,
               less_than_or_equal_to: 12,
             }
end
