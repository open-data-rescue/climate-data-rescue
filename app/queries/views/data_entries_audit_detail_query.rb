# Responsible for returning a collection of items
# Results can be sorted, filtered, and paginated
class Views::DataEntriesAuditDetailQuery < ::BaseQuery
  def tables_hash
    {
      data_entries_audit_details: ::Views::DataEntriesAuditDetail.arel_table,
    }
  end

  def base_collection
    collection || ::Views::DataEntriesAuditDetail.all
  end

  def filter_class
    QueryFilters::AuditFilter
  end

  protected

  def sort_by
    if sort.key == :created_at
      tables.data_entries_audit_details[:change_time]
    else
      tables.data_entries_audit_details[sort.key]
    end
  end
end
