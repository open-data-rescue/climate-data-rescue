class Blog::Post < ApplicationRecord
  validates :author, presence: true, length: {maximum:110, minimum:4}
  validates :title, presence: true, length: {maximum:110, minimum:5}
  validates :content, presence: true, length: {minimum:20}

  acts_as_taggable_on :tags
end


# Blog::Post.create(
#   title: "Test 2", 
#   content: "This is a post 2",
#   author: "W Pooh",
#   job_title: "Editor", 
#   published: true,
#   published_at: Time.now  
# )