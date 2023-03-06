
module Api
  module V1
    class DataEntriesAuditDetailsController < BaseController
      def index
        query = Views::DataEntriesAuditDetailQuery.new(
          collection: policy_scope(Views::DataEntriesAuditDetail),
          filters: query_filters,
          page: query_page,
          sort: query_sort,
        )

        @details = query.resolve

        render jsonapi: @details,
               meta: { total: query.total }
      end

      def jsonapi_class
        {
          'Views::DataEntriesAuditDetail': Api::V1::SerializableDataEntriesAuditDetail
        }
      end

      def available_filters
        %i[id location page_id observaton_date who_id user_id user_name who_name].freeze
      end

      def query_sort
        return {sort: :id} if params[:sort].blank?

        super
      end

    end
  end
end
