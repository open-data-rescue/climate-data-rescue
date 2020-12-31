
module Api
  module V1
    # Returns page data to the API consumer
    class PagesController < BaseController
      def index
        query = PageQuery.new(
          collection: policy_scope(Page)
                        .includes(:page_type)
                        .references(:page_type),
          filters: query_filters,
          page: query_page,
          sort: query_sort,
        )

        @pages = query.resolve

        render jsonapi: @pages,
               include: %i[page_type transcriptions],
               meta: { total: query.total }
      end

      def jsonapi_class
        {
          Page: Api::V1::SerializablePage,
          PageType: Api::V1::SerializablePageType,
          Transcription: Api::V1::SerializableTranscription
        }
      end

      def available_filters
        %i[done end_date id image_file_name page_type_id start_date title visible].freeze
      end
    end
  end
end
