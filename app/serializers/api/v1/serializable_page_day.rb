
module Api
  module V1
    # Serializes the PageDay class
    class SerializablePageDay < ApplicationSerializer
      type 'page_days'

      attribute :num_observations
      attribute :date_datestring do
        I18n.l(@object.date, format: :long)
      end
    end
  end
end