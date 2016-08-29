if field_option

json.id field_option.id
json.name field_option.name
json.help field_option.help
json.value field_option.value
json.image (field_option.image.present? ? field_option.image : nil)
json.text_symbol field_option.text_symbol
json.icon_url (field_option.image.present? ? field_option.image.url(:icon) : nil)
json.assigned (field && field.field_options.include?(field_option) ? true : false)

end
