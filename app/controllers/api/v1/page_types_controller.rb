
module Api
  module V1
    # Returns page type data to the API consumer
    class PageTypesController < BaseController
      def index
        query = PageTypeQuery.new(
          collection: policy_scope(PageType),
          filters: query_filters,
          page: query_page,
          sort: query_sort,
        )

        @page_types = query.resolve

        render jsonapi: @page_types,
               meta: { total: query.total }
      end

      def jsonapi_class
        {
          PageType: Api::V1::SerializablePageType
        }
      end

      def available_filters
        %i[id title].freeze
      end
    end
  end
end
