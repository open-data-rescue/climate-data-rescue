
module Api
  module V1
    # Serializes the Page class
    class SerializablePageType < ApplicationSerializer
      type 'page_types'

      attributes :title
    end
  end
end