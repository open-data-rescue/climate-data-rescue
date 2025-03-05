module QueryFilters
  class BlogPostFilter < BaseFilter
    protected
    def set_filters
      set_id
    end

    def set_id
      return if filters.id.blank?

      # Cast the id column as text to enable a partial match
      filter = Arel::Nodes::NamedFunction.new(
        'CAST',
        [tables.blog_posts[:id].as('CHAR')]
      ).matches("%#{filters.id}%")
      append_condition(filter)
    end

  end
end
