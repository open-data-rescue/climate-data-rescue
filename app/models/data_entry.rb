class DataEntry < ApplicationRecord
	belongs_to :page, required: true
	belongs_to :field, required: true
  belongs_to :user, required: true
  belongs_to :annotation, touch: true, required: true

  validates :field_id,
            uniqueness: { scope: :annotation_id }
  validates :value,
            presence: true
  validates :data_type,
            presence: true
end