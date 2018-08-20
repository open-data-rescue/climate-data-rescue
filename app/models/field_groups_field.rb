class FieldGroupsField < ActiveRecord::Base
    belongs_to :field
    belongs_to :field_group

    validates :sort_order,
              presence: true

    include RankedModel
    ranks :sort_order
end
