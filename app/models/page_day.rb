class PageDay < ActiveRecord::Base
  belongs_to :page #, foreign_key: "ledger_id"

  
end
