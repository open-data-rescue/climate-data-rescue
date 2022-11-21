class Transcription < ApplicationRecord
  belongs_to :page, required: true
  belongs_to :user, required: true
  has_one :page_type, through: :page
  has_many :field_groups, through: :page_type
  has_many :field_groups_fields, through: :field_groups, counter_cache: :field_groups_fields_count
  has_many :fields, through: :field_groups
  has_many :annotations, dependent: :destroy
  has_many :data_entries, through: :annotations, counter_cache: :data_entries_count

  validates :page_id, uniqueness: { scope: :user_id }

  before_save :update_row_counters

  scope :completed, -> { where(complete: true) }
  scope :in_progress, -> { where(complete: false) }

  def self.most_recent_by_page_and_user
    reorder(page_id: :asc, user_id: :asc, updated_at: :desc)
  end

  def num_rows_started
    started_rows_count
  end

  def num_rows_expected
    expected_rows_count
  end

  def num_data_entries
    data_entries_count
  end

  def num_data_entries_expected
    field_groups_fields_count * num_rows_expected
  end

  def percent_complete
    ((num_data_entries.to_f / num_data_entries_expected.to_f) * 100) || 0
  end

  private

  def update_row_counters
    self.started_rows_count = annotations.pluck(:observation_date).uniq.size
    self.expected_rows_count = page.num_rows_expected || 0
  end
end
