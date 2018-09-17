
class RankedJoinBase < ApplicationRecord
  self.abstract_class = true
  include RankedModel

  validates :sort_order,
            presence: true,
            on: :update

  ranks :sort_order
end
