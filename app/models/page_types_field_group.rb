class PageTypesFieldGroup < RankedJoinBase
  belongs_to :page_type
  belongs_to :field_group
end
