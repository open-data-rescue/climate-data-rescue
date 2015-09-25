class Ledger < ActiveRecord::Base
  attr_accessible :author, :extern_ref, :title, :pagetype_id
  has_many :pagetypes
end
