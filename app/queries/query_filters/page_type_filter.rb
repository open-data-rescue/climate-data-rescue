module QueryFilters
  # Set filters for a PageTypeQuery instance
  class PageTypeFilter < BaseFilter
    protected

    def set_filters
      set_id
      set_title
    end

    def set_title
      return if filters.title.blank?

      # allow partial matches on the account name
      append_condition(
        tables.page_types[:title].matches("%#{filters.title}%")
      )
    end

    def set_id
      return if filters.id.blank?

      # Cast the id column as text to enable a partial match
      filter = Arel::Nodes::NamedFunction.new(
        'CAST',
        [tables.page_types[:id].as('CHAR')]
      ).matches("%#{filters.id}%")
      append_condition(filter)
    end

  end
end
