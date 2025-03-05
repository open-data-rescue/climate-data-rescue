module Api
  module V1
    class BlogPostsController < BaseController
      def index
        query = BlogPostQuery.new(
          collection: policy_scope(Blog::Post), #.where(where_condition),
          filters: query_filters,
          page: query_page,
          sort: query_sort,
          query_op: query_op
        )

        @posts = query.resolve

        render jsonapi: @posts,
               meta: {
                 total: query.total,
                 current_page: query.page.number,
                 per_page: query.page.size
               }
      end

      def jsonapi_class
        {
          BlogPost: Api::V1::SerializableBlogPost,
        }
      end

      def available_filters
        %i[id ].freeze
      end

      def query_sort
        return {sort: :updated_at} if params[:sort].blank?

        super
      end

      def where_condition
        return nil if params[:'query:where'].blank?

        condition = params.permit(:'query:where')[:'query:where']
        if (condition == 'review_transcriptions')
          {
            complete: true,
            pages: {
              done: false
            }
          }
        else
          nil
        end
      end

    end
  end
end
