class Transcription < ActiveRecord::Base
  belongs_to :page
  belongs_to :user
  has_one :page_type, through: :page
  has_many :field_groups, through: :page_type
  has_many :field_groups_fields, through: :field_groups
  has_many :fields, through: :field_groups
  has_many :annotations, dependent: :destroy
  has_many :data_entries, through: :annotations

  validates :page_id, uniqueness: { scope: :user_id }, presence: true
  validates :user_id, presence: true

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
