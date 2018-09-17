class Transcription < ApplicationRecord
  belongs_to :page, required: true
  belongs_to :user, required: true
  has_one :page_type, through: :page
  has_many :field_groups, through: :page_type
  has_many :field_groups_fields, through: :field_groups
  has_many :fields, through: :field_groups
  has_many :annotations, dependent: :destroy
  has_many :data_entries, through: :annotations

  validates :page_id, uniqueness: { scope: :user_id }

  def num_rows_started
    annotations.pluck(:observation_date).uniq.size
  end

  def num_rows_expected
    page.num_rows_expected || 0
  end

  def num_data_entries
    data_entries.count
  end

  def num_data_entries_expected
    field_groups_fields.size * num_rows_expected
  end

  def percent_complete
    ((num_data_entries.to_f / num_data_entries_expected.to_f) * 100) || 0
  end
end
