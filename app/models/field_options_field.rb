class FieldOptionsField < ActiveRecord::Base
    belongs_to :field
    belongs_to :field_option
end
