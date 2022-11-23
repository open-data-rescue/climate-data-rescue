module QueryFilters
  # Set filters for a PageQuery instance
  class TranscriptionFilter < BaseFilter
    protected

    def set_filters
      set_id
      set_title
      set_user_display_name
    end

    def set_id
      return if filters.id.blank?

      # Cast the id column as text to enable a partial match
      filter = Arel::Nodes::NamedFunction.new(
        'CAST',
        [tables.transcriptions[:id].as('CHAR')]
      ).matches("%#{filters.id}%")
      append_condition(filter)
    end

    def set_title
      return if filters.title.blank?

      append_condition(
        tables.page[:title].matches("%#{filters.title}%")
      )
    end

    def set_user_display_name
      return if filters['user.display_name'].blank?

      append_condition(
        tables.user[:display_name].matches("%#{filters['user.display_name']}%")
      )
    end
  end
end
