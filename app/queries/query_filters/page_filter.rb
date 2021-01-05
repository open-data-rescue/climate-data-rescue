module QueryFilters
  # Set filters for a PageQuery instance
  class PageFilter < BaseFilter
    protected

    def set_filters
      set_id
      set_done
      set_end_date
      set_image_file_name
      set_page_type_id
      set_page_days
      set_start_date
      set_title
      set_transcriptions
      set_visible
    end

    def set_id
      return if filters.id.blank?

      # Cast the id column as text to enable a partial match
      filter = Arel::Nodes::NamedFunction.new(
        'CAST',
        [tables.pages[:id].as('CHAR')]
      ).matches("%#{filters.id}%")
      append_condition(filter)
    end

    def set_done
      return if filters.done.blank?

      # allow partial matches on the account name
      append_condition(
        tables.pages[:done].eq(filters.done)
      )
    end

    def set_end_date
      return if filters.end_date.blank?

      # Cast the end_date column as text to enable a partial match
      filter = Arel::Nodes::NamedFunction.new(
        'CAST',
        [tables.pages[:end_date].as('CHAR')]
      ).matches("%#{filters.end_date}%")
      append_condition(filter)
    end

    def set_image_file_name
      return if filters.image_file_name.blank?

      # allow partial matches on the account name
      append_condition(
        tables.pages[:image_file_name].matches("%#{filters.image_file_name}%")
      )
    end

    def set_page_type_id
      return if filters.page_type_id.blank?

      # allow partial matches on the account name
      append_condition(
        tables.pages[:page_type_id].eq(filters.page_type_id)
      )
    end

    def set_page_days
      return if filters.page_days.blank?

      if filters.page_days === 'true'
        append_condition(
          tables.pages[:id].in(
            tables.page_days.project(tables.page_days[:page_id])
          )
        )
      else
        # no page_days, where the page id is not in the page_days
        append_condition(
          tables.pages[:id].not_in(
            tables.page_days.project(tables.page_days[:page_id])
          )
        )
      end
    end

    def set_start_date
      return if filters.start_date.blank?

      # Cast the start_date column as text to enable a partial match
      filter = Arel::Nodes::NamedFunction.new(
        'CAST',
        [tables.pages[:start_date].as('CHAR')]
      ).matches("%#{filters.start_date}%")
      append_condition(filter)
    end

    def set_title
      return if filters.title.blank?

      # allow partial matches on the account name
      append_condition(
        tables.pages[:title].matches("%#{filters.title}%")
      )
    end

    def set_transcriptions
      return if filters.transcriptions.blank?

      if filters.transcriptions === 'true'
        append_condition(
          tables.pages[:id].in(
            tables.transcriptions.project(tables.transcriptions[:page_id])
          )
        )
      else
        # no transcriptions, where the page id is not in the transcriptions
        append_condition(
          tables.pages[:id].not_in(
            tables.transcriptions.project(tables.transcriptions[:page_id])
          )
        )
      end
    end

    def set_visible
      return if filters.visible.blank?

      # allow partial matches on the account name
      append_condition(
        tables.pages[:visible].eq(filters.visible)
      )
    end
  end
end
