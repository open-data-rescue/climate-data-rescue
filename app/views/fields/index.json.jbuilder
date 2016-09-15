
json.array! @fields do |field|
    json.partial! 'field', field: field
end
