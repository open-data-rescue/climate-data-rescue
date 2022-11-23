module QueryFilters
  # Set filters for a PageQuery instance
  class TranscriptionFilter < BaseFilter
    protected

    def set_filters
      set_id
      set_title
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

      # allow partial matches on the account name
      append_condition(
        tables.page[:title].matches("%#{filters.title}%")
      )
    end
  end
end
