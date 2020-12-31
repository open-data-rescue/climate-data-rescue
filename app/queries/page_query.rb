# Responsible for returning a collection of items
# Results can be sorted, filtered, and paginated
class PageQuery < BaseQuery
  def tables_hash
    {
      pages: ::Page.arel_table,
      transcriptions: ::Transcription.arel_table
    }
  end

  def base_collection
    collection || ::Page.all
  end

  def filter_class
    QueryFilters::PageFilter
  end

  protected

  def sort_by
    tables.pages[sort.key]
  end
end
