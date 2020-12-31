
module Api
  module V1
    # Serializes the PageType class
    class SerializablePageType < ApplicationSerializer
      type 'page_types'

      attributes :title

      link :admin_detail do
        @url_helpers.admin_page_type_url(@object.id)
      end
    end
  end
end