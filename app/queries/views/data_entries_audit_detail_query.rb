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
    QueryFilters::PageFilter
  end

  protected

  def sort_by
    if sort.key == :created_at
      tables.data_entries_audit_details[:change_time]
      # puts "****** #{sort.key}"
      # tables.data_entries_audit_details[sort.key]
      # col_table_name, col = sort.key.to_s.split('.')
      # tables.send(col_table_name)[col]
    else
      tables.data_entries_audit_details[sort.key]
    end
  end
end
