module QueryFilters
  # Set filters for a PageQuery instance
  class AuditFilter < BaseFilter
    protected

    def set_filters
      set_page_title
      set_who_name
      set_event
    end

    def set_id
      return if filters.id.blank?

      # Cast the id column as text to enable a partial match
      filter = Arel::Nodes::NamedFunction.new(
        'CAST',
        [tables.data_entries_audit_details[:id].as('CHAR')]
      ).matches("%#{filters.id}%")
      append_condition(filter)
    end

    def set_page_title
      return if filters.page_title.blank?

      append_condition(
        tables.data_entries_audit_details[:page_title].matches("%#{filters.page_title}%")
      )
    end

    def set_who_name
      return if filters.who_name.blank?

      append_condition(
        tables.data_entries_audit_details[:who_name].matches("%#{filters.who_name}%")
      )
    end

    def set_event
      return if filters.event.blank?

      append_condition(
        tables.data_entries_audit_details[:event].matches("%#{filters.event}%")
      )
    end
  end
end
