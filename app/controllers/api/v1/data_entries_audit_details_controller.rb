
module Api
  module V1
    class DataEntriesAuditDetailsController < BaseController
      def index
        query = Views::DataEntriesAuditDetailQuery.new(
          collection: policy_scope(Views::DataEntriesAuditDetail),
          filters: query_filters,
          page: query_page,
          sort: query_sort,
          query_op: query_op
        )

        @details = query.resolve

        render jsonapi: @details,
               meta: {
                 total: query.total,
                 current_page: query.page.number,
                 per_page: query.page.size
               }
      end

      def jsonapi_class
        {
          'Views::DataEntriesAuditDetail': Api::V1::SerializableDataEntriesAuditDetail
        }
      end

      def available_filters
        %i[id event page_title who_name].freeze
      end

      def query_sort
        return {sort: :change_time} if params[:sort].blank?

        super
      end

    end
  end
end
