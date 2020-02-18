
class BetterTogether::Post < ApplicationRecord
  include ::BetterTogether::FriendlySlug
  slugged :title

  translates :title
  translates :content, type: :text

  validates :title,
            presence: true

  validates :content,
            presence: true
end
