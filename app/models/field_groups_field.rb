class FieldGroupsField < RankedJoinBase
  belongs_to :field
  belongs_to :field_group
end
