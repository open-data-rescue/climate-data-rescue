class Blog::Post < ApplicationRecord
  validates :author, presence: true, length: {maximum:110, minimum:4}
  validates :title, presence: true, length: {maximum:110, minimum:10}
  validates :content, presence: true, length: {minimum:20}

  acts_as_taggable_on :tags
end
