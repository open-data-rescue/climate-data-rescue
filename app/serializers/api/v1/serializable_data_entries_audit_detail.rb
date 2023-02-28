module Api
  module V1
    class SerializableDataEntriesAuditDetail < ApplicationSerializer
      type 'data_entries_audit_detail'

      attributes :id, :user_name, :page_title, :location,
                 :observation_date, :field_key,
                 :value, :prev_value, :notes, :whodunnit,
                 :change_time, :event, :who_name,
                 :who_id, :user_id

      attribute :created_at_datestring do
        return nil unless @object.change_time
        @object.change_time ? I18n.l(@object.change_time, format: :long) : nil
      end

      attribute :updated_at_datestring do
        return nil unless @object.change_time
        @object.change_time ? I18n.l(@object.change_time, format: :long) : nil
      end
    end
  end
end

#
# adev.id as id,
# u.id as user_id,
# u.display_name as user_name,
# p.id as page_id,
# p.title as page_title,
# pi.location,
# t.id as transcription_id,
# a.id as annotation_id,
# a.observation_date,
# de.field_id,
# f.field_key,
# adev.value,
# adev.prev_value,
# adev.notes,
# adev.whodunnit,
# adev.created_at as change_time,
# adev.event,
# who.id who_id,
# who.display_name who_name
