class DataEntry < ActiveRecord::Base
	belongs_to :page
	belongs_to :user
	belongs_to :annotation, touch: true
	belongs_to :field

  validates :field_id, uniqueness: { scope: :annotation_id }, presence: true
  validates :annotation_id, presence: true
  validates :page_id, presence: true

end