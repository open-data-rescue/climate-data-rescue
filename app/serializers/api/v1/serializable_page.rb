
module Api
  module V1
    # Serializes the Page class
    class SerializablePage < ApplicationSerializer
      type 'pages'

      has_one :page_type

      attributes :title, :start_date, :end_date, :visible, :done, :image_file_name
    end
  end
end