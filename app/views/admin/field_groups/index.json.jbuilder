
json.array! @field_groups do |field_group|
    json.partial! 'field_group', field_group: field_group, page_type: @page_type
end
