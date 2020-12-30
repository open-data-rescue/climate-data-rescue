
module Api
  module V1
    # Serializes the Page class
    class SerializablePage < ApplicationSerializer
      type 'pages'

      attributes :title, :start_date, :end_date, :visible, :done
    end
  end
end