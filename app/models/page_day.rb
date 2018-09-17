class PageDay < ApplicationRecord
  belongs_to :page #, foreign_key: "ledger_id"

  
end
