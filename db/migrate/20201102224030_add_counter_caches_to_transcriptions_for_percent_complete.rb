class AddCounterCachesToTranscriptionsForPercentComplete < ActiveRecord::Migration[5.2]
  def change
    add_column :transcriptions,
               :field_groups_fields_count,
               :integer,
               null: false,
               default: 0
    add_column :transcriptions,
               :data_entries_count,
               :integer,
               null: false,
               default: 0
    add_column :transcriptions,
               :started_rows_count,
               :integer,
               null: false,
               default: 0
    add_column :transcriptions,
               :expected_rows_count,
               :integer,
               null: false,
               default: 0
  end
end
