field_group = field_group || nil
if field
    json.id field.id
    json.internal_name field.internal_name
    json.name field.name
    json.full_name field.full_name
    json.field_key field.field_key
    json.html_field_type field.html_field_type
    json.data_type field.data_type
    json.help field.help
    json.multi_select field.multi_select
    json.has_options field.field_options.any?
    json.num_field_values field.field_options.count

    json.assigned (field_group && field_group.fields.include?(field) ? true : false)

    if @fgf
        json.position @fgf.sort_order
    end
end
