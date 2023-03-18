class Views::AnnotationsAndDataEntry < ApplicationRecord
  self.table_name = :annotations_and_data_entries
  self.primary_key = :data_entry_id

  belongs_to :field
  belongs_to :data_entry
  has_many :field_options_fields, through: :field
  has_many :field_options, through: :field_options_fields

end
