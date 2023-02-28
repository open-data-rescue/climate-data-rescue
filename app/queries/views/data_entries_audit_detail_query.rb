# Responsible for returning a collection of items
# Results can be sorted, filtered, and paginated
class DataEntriesAuditDetailQuery < BaseQuery
  def tables_hash
    {
    }
  end

  def base_collection
    collection || ::Views::DataEntriesAuditDetail.all
  end

  def filter_class
    QueryFilters::PageFilter
  end

  protected

  def sort_by
    tables.pages[sort.key]
  end
end
