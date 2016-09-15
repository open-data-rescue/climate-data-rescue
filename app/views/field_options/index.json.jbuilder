json.array! @field_options do |field_option|

    json.partial! 'field_option', field_option: field_option, field: @field 

end