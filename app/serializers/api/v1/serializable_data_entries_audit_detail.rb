module Api
  module V1
    class SerializableDataEntriesAuditDetail < ApplicationSerializer
      type 'data_entries_audit_detail'

      attributes :id
      # attribute :date_datestring do
      #   I18n.l(@object.date, format: :long)
      # end
    end
  end
end
