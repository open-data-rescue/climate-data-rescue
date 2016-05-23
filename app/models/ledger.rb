class Ledger < ActiveRecord::Base
  #attr_accessible :author, :extern_ref, :title, :pagetype_id
  #TODO: remove :pagetype_id attribute from database and attr_accessible and update the form views for ledger
  has_many :page_types
  has_many :pages, through: :page_types
end
