class PageType < ActiveRecord::Base
  has_many :pages
  has_many :field_groups,
           -> { order("page_types_field_groups.sort_order asc") },
           through: :page_types_field_groups
  has_many :page_types_field_groups, dependent: :destroy
  has_many :fields, through: :field_groups
  has_many :transcriptions, through: :pages
  has_many :annotations, through: :transcriptions

  belongs_to :ledger

  validates :title,
            presence: true
end
