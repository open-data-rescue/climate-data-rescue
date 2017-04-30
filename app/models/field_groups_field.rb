class FieldGroupsField < ActiveRecord::Base
    belongs_to :field
    belongs_to :field_group

    include RankedModel
    ranks :sort_order
end
