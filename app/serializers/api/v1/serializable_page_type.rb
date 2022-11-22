
module Api
  module V1
    # Serializes the PageType class
    class SerializablePageType < ApplicationSerializer
      type 'page_type'

      attributes :id, :title

      attribute :admin_detail_url do
        @url_helpers.admin_page_type_url(@object.id)
      end
    end
  end
end
