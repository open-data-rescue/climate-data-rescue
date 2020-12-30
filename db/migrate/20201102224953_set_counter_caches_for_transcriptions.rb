class SetCounterCachesForTranscriptions < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Transcription.includes(
            :annotations,
            :data_entries,
            :field_groups_fields,
            {
              page: [
                :page_days,
                {
                  page_type: [
                    :page_types_field_groups
                  ]
                }
              ]
            }
          ).find_each do |transcription|
          transcription.data_entries_count = transcription.data_entries.size
          transcription.field_groups_fields_count = transcription.field_groups_fields.size
          transcription.started_rows_count = transcription.annotations.pluck(:observation_date).uniq.size
          transcription.expected_rows_count = transcription.page.num_rows_expected || 0
          transcription.save
        end
      end
    end
  end
end
