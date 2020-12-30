# Responsible for returning a collection of items
# Results can be sorted, filtered, and paginated
class PageQuery < BaseQuery
  def tables_hash
    {
      pages: ::Page.arel_table
    }
  end

  def base_collection
    collection || ::Page.all
  end

  def filter_class
    QueryFilters::PageFilter
  end

  def call(sort: nil, page: nil, filters: {}, paginated: true)
    new(sort: sort, page: page, filters: filters)
    resolve(paginated: paginated)
  end

  protected

  def sort_by
    tables.pages[sort.key]
  end
end
