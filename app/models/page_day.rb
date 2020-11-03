class PageDay < ApplicationRecord
  belongs_to :page, autosave: true
end
