class FieldOptionsField < ActiveRecord::Base
    include RankedModel
    
    belongs_to :field
    belongs_to :field_option

    validates :sort_order,
              presence: true

    ranks :sort_order
end
