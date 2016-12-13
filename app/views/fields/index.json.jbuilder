
json.array! @fields do |field|
    json.partial! 'field', field: field, field_group: @field_group
end
