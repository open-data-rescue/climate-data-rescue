class PageType < ApplicationRecord
  belongs_to :ledger

  has_many :pages
  has_many :page_types_field_groups, dependent: :destroy
  has_many :field_groups,
           -> { order("page_types_field_groups.sort_order asc") },
           through: :page_types_field_groups
  has_many :fields, through: :field_groups
  has_many :transcriptions, through: :pages
  has_many :annotations, through: :transcriptions
  has_many :data_entries, through: :transcriptions

  validates :title,
            presence: true
  validates :ledger_type,
            presence: true
  validates :number,
            presence: true

  def sorted_fields
    fields.reorder("page_types_field_groups.sort_order asc, page_types_field_groups.sort_order asc")
  end
end
