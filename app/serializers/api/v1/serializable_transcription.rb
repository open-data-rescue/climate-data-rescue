
module Api
  module V1
    # Serializes the Transcription class
    class SerializableTranscription < ApplicationSerializer
      type 'transcription'

      has_one :user
      has_one :page

      attribute :admin_detail_url do
        @url_helpers.admin_transcription_url(@object.id)
      end

      attribute :admin_edit_url do
        @url_helpers.edit_transcription_url(@object.id)
      end

      attribute :download_json_url do
        @url_helpers.transcription_path(@object, format: :json)
      end

      attribute :download_csv_url do
        @url_helpers.transcription_path(@object, format: :csv)
      end

      attributes :id, :percent_complete,
                 :data_entries_count, :started_rows_count, :expected_rows_count,
                 :created_at, :updated_at, :num_data_entries_expected,
                 :complete

      # page title, fields transcribed, fields total, , rows started, rows total, started_at, :updated_at, page_schema, user

      attribute :page_image_url do
        @object.page.image.url(:thumb)
      end

      attribute :admin_page_url do
        @url_helpers.admin_page_url(@object.page_id)
      end
    end
  end
end
