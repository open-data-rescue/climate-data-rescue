
module Api
  module V1
    # Serializes the Page class
    class SerializablePage < ApplicationSerializer
      type 'pages'

      has_one :page_type

      attributes :title, :start_date, :end_date, :visible, :done, :image_file_name

      link :admin_detail do
        @url_helpers.admin_page_url(@object.id)
      end

      link :admin_edit do
        @url_helpers.edit_admin_page_url(@object.id)
      end

      link :admin_delete do
        @url_helpers.admin_page_url(@object.id)
      end
    end
  end
end