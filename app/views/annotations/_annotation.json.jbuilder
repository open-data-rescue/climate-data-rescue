if annotation
    json.id annotation.id
    json.date annotation.date_time_id.split("_")[0]
    json.time annotation.date_time_id.split("_")[1]
    json.width annotation.width
    json.height annotation.height
    json.x_tl annotation.x_tl
    json.y_tl annotation.y_tl
    json.created_at annotation.created_at
    json.updated_at annotation.updated_at
    json.date_time_id annotation.date_time_id
    json.observation_date annotation.observation_date.utc.strftime('%d %b %Y, %I:%M %p')
    json.page_id annotation.page_id
    json.transcription_id annotation.transcription_id
    json.field_group_id annotation.field_group_id
    
    json.field_group do
        json.id annotation.field_group_id
        json.name annotation.field_group.presentation_name
        json.colour_class annotation.field_group.colour_class
        json.fields do
            json.array! annotation.field_group.fields do |field|
                entry = annotation.data_entries.find_by(field_id: field.id)
                json.id field.id
                json.name field.name
                json.value (entry ? entry.value : nil )
                json.has_options field.field_options.any?
                if entry && entry.field_options_ids
                    selected_options = []
                    selected_options = entry.field_options_ids.split(",").collect{|id| FieldOption.find(id)}

                    json.selected_options do
                        json.array! selected_options do |option|
                            json.partial! "field_options/field_option", field_option: option
                        end
                    end
                end
            end
        end
    end
end