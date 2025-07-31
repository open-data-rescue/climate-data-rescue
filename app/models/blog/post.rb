class Blog::Post < ApplicationRecord
  validates :author, presence: true, length: {maximum:110, minimum:4}
  validates :title, presence: true, length: {maximum:110, minimum:5}
  validates :content, presence: true, length: {minimum:20}

  translates :title, :content

  acts_as_taggable_on :tags
end
