module Api
  module V1
    class BlogPostsController < BaseController
      before_action :load_resource_instance, only: [:show, :create, :update, :destroy]

      def index
        authorize ::Blog::Post, policy_class: ::Blog::PostPolicy
        
        query = BlogPostQuery.new(
          collection: policy_scope(::Blog::Post), #.where(where_condition),
          filters: query_filters,
          page: query_page,
          sort: query_sort,
          query_op: query_op
        )

        @posts = query.resolve

        render jsonapi: @posts,
               class: { 'Blog::Post': Api::V1::SerializableBlogPost}, 
               meta: {
                 total: query.total,
                 current_page: query.page.number,
                 per_page: query.page.size
               }
      end

      def show
        authorize @object, policy_class: ::Blog::PostPolicy
        render_object(@object)
      end

      def create
        ::Blog::Post.transaction do
          authorize @object, policy_class: ::Blog::PostPolicy
          @object.save!
        end
        render_object(@object)
      end

      def update
        ::Blog::Post.transaction do
          authorize @object, policy_class: ::Blog::PostPolicy
          # updates does the save as well, need to assign without saving to determine if there is a change
          @object.assign_attributes(params.permit(allowed_params))
          # @object.assign_attributes(strip_params(_permitted_params(model: object_name, instance: @object)))
          @object.save!
          @object.reload
        end

        render_object(@object)
      end

      def destroy
        ::Blog::Post.transaction do
          authorize @object, policy_class: ::Blog::PostPolicy
          @object.destroy
          render status: :ok, json: {}.to_json, content_type: 'application/json'
        end
      end

      def render_object(object)
        render jsonapi: object,
               class: { 'Blog::Post': Api::V1::SerializableBlogPost}
      end

      def load_resource_instance
        Rails.logger.debug "*** LOAD #{params}"
        resource_id = params[:id]
        if resource_id
          return nil unless policy_scope(::Blog::Post).exists?(resource_id)

          @object = policy_scope(::Blog::Post).find(resource_id)    
        else
          ::Blog::Post.new(params.permit(allowed_params))
        end              
      end

      def allowed_params
        %i[
          id
          lock_version
          title
          content
          author
          slug
          job_title
          published
          published_at
        ]
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
