
module Api
  module V1
    class SerializableBlogPost < ApplicationSerializer
      type 'blog_post'

      attributes :id, :lock_version, :created_at, :updated_at,
                 :title, :content, :author, :slug, :job_title,
                 :published, :published_at

      attribute :published_at_datestring do
        return nil unless @object.published_at
        I18n.l(@object.published_at, format: :long)
      end

      # Tags
      attribute :tag_list do #|post|
        @object.taggings.select{|t| t.context == 'tags'}.collect(&:tag).collect(&:name)
      end
    end
  end
end
