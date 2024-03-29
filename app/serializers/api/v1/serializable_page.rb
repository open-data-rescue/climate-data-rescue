
module Api
  module V1
    # Serializes the Page class
    class SerializablePage < ApplicationSerializer
      type 'page'

      has_one :page_type
      has_many :transcriptions
      has_many :page_days

      attributes :id, :title, :start_date, :end_date, :visible, :done,
                 :image_file_name, :created_at, :updated_at, :page_type_id

      attribute :admin_detail_url do
        @url_helpers.admin_page_url(@object.id)
      end

      attribute :admin_edit_url do
        @url_helpers.edit_admin_page_url(@object.id)
      end

      attribute :admin_delete_url do
        @url_helpers.admin_page_url(@object.id)
      end

      attribute :page_metadata do
        if @object.has_page_metadata?
          "Observer: #{@object.page_info.observer} | Lat: #{@object.page_info.lat} | Lon: #{@object.page_info.lon} | Location: #{@object.page_info.location} | Elevation: #{@object.page_info.elevation}"
        end
      end
    end
  end
end
