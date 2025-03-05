
module Api
  module V1
    class SerializableBlogPost < ApplicationSerializer
      type 'blog_post'

      attributes :id, :lock_version, :created_at, :updated_at,
                 :title, :content, :author, :slug, :job_title,
                 :published, :published_at

      # TODO: tags
    end
  end
end
