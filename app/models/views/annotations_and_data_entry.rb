class Views::AnnotationsAndDataEntry < ApplicationRecord
  self.table_name = :annotations_and_data_entries
  self.primary_key = :data_entry_id
end
