
if @transcriptions.present?
  json.array! @transcriptions do |transcription|
    dates = transcription.annotations.order_by_date.group_by do |a|
      a.observation_date.utc.to_date
    end

    json.id transcription.id

    json.page do
      json.id transcription.page.id
      json.title transcription.page.title
      if transcription.page.has_metadata?
        json.start_date transcription.page.page_days.first.date
        json.end_date transcription.page.page_days.last.date
      else
        json.start_date transcription.page.start_date
        json.end_date transcription.page.end_date
      end
      json.schema do
        json.title transcription.page_type.title
        json.ledger_type transcription.page_type.ledger_type
        json.number transcription.page_type.number
        json.fields transcription.fields.map(&:name)
      end
    end

    json.rows do
      dates.each do |date, date_annotations|
        times = date_annotations.group_by { |a| a.observation_date.utc }
        json.array! times do |time, time_annotations|
          json.set! :date, date.to_s
          json.set! :time, time.strftime('%H:%M')

          transcription.page_type.field_groups.each do |group|
            annotation = time_annotations.select{|a| a.field_group == group}.first

            group.fields.each do |field|
              entry = transcription.data_entries.find_by(field_id: field.id, annotation_id: annotation.id) if annotation

              value = nil
              value = entry.value if entry.present?

              json.set! field.field_key, value
            end
          end
        end
      end
    end
  end
end
