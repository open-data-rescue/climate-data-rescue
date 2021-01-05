# Responsible for returning a collection of items
# Results can be sorted, filtered, and paginated
class PageTypeQuery < BaseQuery
  def tables_hash
    {
      page_types: ::PageType.arel_table
    }
  end

  def base_collection
    collection || ::PageType.all
  end

  def filter_class
    QueryFilters::PageTypeFilter
  end

  protected

  def sort_by
    tables.page_types[sort.key]
  end
end
