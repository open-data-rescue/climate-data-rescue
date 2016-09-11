
if field
    json.id field.id
    json.name field.name
    json.full_name field.full_name
    json.field_key field.field_key
    json.html_field_type field.html_field_type
    json.data_type field.data_type
    json.help field.help
    json.multi_select field.multi_select
    json.position field.position
    json.has_options field.field_options.any?
end
