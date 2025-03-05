# class Blog::PostsController < ::ResourceController
#   SERIALIZER_CLASS = 'Blog::PostSerializer'.freeze
#   POLICY_CLASS = 'Blog::PostPolicy'.freeze
#   DEFAULT_SORTBY = 'updated_at'.freeze
#   DEFAULT_ORDER = 'desc'.freeze

#   def paginate
#     !params[:perPage].blank?
#   end

#   def allowed_params
#     %i[
#       id
#       lock_version
#       title
#       content
#       author
#       slug
#       job_title
#       published
#     ]
#   end
# end
