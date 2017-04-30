class PageTypesFieldGroup < ActiveRecord::Base
    belongs_to :page_type
    belongs_to :field_group

    include RankedModel
    ranks :sort_order
end
