
class RankedJoinBase < ActiveRecord::Base
  self.abstract_class = true
  include RankedModel

  validates :sort_order,
            presence: true

  ranks :sort_order
end
