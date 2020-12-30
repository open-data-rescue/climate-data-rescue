
module Api
  module V1
    # Returns page data to the API consumer
    class PagesController < BaseController
      def index
        query = PageQuery.new(
          filters: query_filters,
          page: query_page,
          sort: query_sort,
        )

        @pages = query.resolve

        render jsonapi: @pages,
               include: %i[page_type],
               meta: { total: query.total }
      end

      def jsonapi_class
        {
          Page: Api::V1::SerializablePage,
          PageType: Api::V1::SerializablePageType
        }
      end

      def available_filters
        %i[id title start_date end_date visible done image_file_name].freeze
      end
    end
  end
end
