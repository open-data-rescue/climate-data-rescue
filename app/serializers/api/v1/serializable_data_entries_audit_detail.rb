module Api
  module V1
    class SerializableDataEntriesAuditDetail < ApplicationSerializer
      type 'data_entries_audit_detail'

      attributes :id, :user_name, :page_title, :location,
                 # :observation_date,
                 :field_key,
                 :value, :prev_value, :notes, :whodunnit,
                 :change_time, :event, :who_name,
                 :who_id, :user_id,
                 :transcription_id

      attribute :created_at_datestring do
        return nil unless @object.change_time
        @object.change_time ? I18n.l(@object.change_time, format: :long) : nil
      end

      attribute :updated_at_datestring do
        return nil unless @object.change_time
        @object.change_time ? I18n.l(@object.change_time, format: :long) : nil
      end

      attribute :observation_date do
        @object.observation_date.utc.strftime('%d %b %Y, %I:%M %p')
      end
    end
  end
end
