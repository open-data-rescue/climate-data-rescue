
module Api
  module V1
    # Serializes the Transcription class
    class SerializableTranscription < ApplicationSerializer
      type 'transcription'

      has_one :user

      attribute :admin_detail_url do
        @url_helpers.admin_transcription_url(@object.id)
      end

      attributes :id, :percent_complete
    end
  end
end
