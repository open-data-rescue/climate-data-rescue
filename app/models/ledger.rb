class Ledger < ActiveRecord::Base
  has_many :page_types, dependent: :destroy
  has_many :pages, through: :page_types

  validates :title,
            presence: true
  validates :ledger_type,
            presence: true
end
