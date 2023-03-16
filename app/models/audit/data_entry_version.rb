module Audit
  class DataEntryVersion < PaperTrail::Version
    self.table_name = :audit_data_entry_versions
  end
end
