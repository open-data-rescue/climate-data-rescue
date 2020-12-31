
module Api
  module V1
    # Serializes the Transcription class
    class SerializableTranscription < ApplicationSerializer
      type 'transcriptions'

      has_one :user

      link :admin_detail do
        @url_helpers.admin_transcription_url(@object.id)
      end

      attribute :percent_complete
    end
  end
end