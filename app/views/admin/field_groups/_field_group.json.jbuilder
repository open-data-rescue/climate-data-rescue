page_type = page_type || nil
if field_group
    json.id field_group.id
    json.name field_group.name
    json.display_name field_group.display_name
    json.help field_group.help
    json.colour_class field_group.colour_class

    json.assigned (page_type && page_type.field_groups.include?(field_group) ? true : false)

    json.num_fields field_group.fields.count

    if @ptfg
        json.position @ptfg.sort_order
    end
end
