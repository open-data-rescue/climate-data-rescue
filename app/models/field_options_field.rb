class FieldOptionsField < ActiveRecord::Base
    belongs_to :field
    belongs_to :field_option

    include RankedModel
    ranks :sort_order
end
