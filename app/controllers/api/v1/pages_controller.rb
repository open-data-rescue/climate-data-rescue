
module Api
  module V1
    # Returns page data to the API consumer
    class PagesController < BaseController
      def index
        @pages = Page.all

        render jsonapi: @pages
      end

      def jsonapi_class
        {
          Page: Api::V1::SerializablePage
        }
      end
    end
  end
end
