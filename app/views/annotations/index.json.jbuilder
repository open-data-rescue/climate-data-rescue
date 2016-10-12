json.array! @annotations do |annotation|
    json.partial! 'annotation', annotation: annotation
end