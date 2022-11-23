
module Api
  module V1
    # Returns page data to the API consumer
    class TranscriptionsController < BaseController
      # TODO: scope this ??
      def index
        query = TranscriptionQuery.new(
          collection: policy_scope(Transcription)
                        .joins(:page, :user),
                        # .references(:page),
          filters: query_filters,
          page: query_page,
          sort: query_sort,
          query_op: query_op
        )

        @transcriptions = query.resolve

        render jsonapi: @transcriptions,
               include: ['user','page', 'page.page_type'],
               meta: {
                 total: query.total,
                 current_page: query.page.number,
                 per_page: query.page.size
               }
      end

      def jsonapi_class
        {
          PageType: Api::V1::SerializablePageType,
          Page: Api::V1::SerializablePage,
          User: Api::V1::SerializableUser,
          Transcription: Api::V1::SerializableTranscription
        }
      end

      def available_filters
        # done end_date id image_file_name
        # page_type_id page_days start_date title transcriptions visible
        %i[
          id title user.display_name
        ].freeze
      end
    end
  end
end
