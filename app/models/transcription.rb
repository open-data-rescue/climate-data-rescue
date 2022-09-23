class Transcription < ApplicationRecord
  belongs_to :page, required: true
  belongs_to :user, required: true
  has_one :page_type, through: :page
  has_many :field_groups, through: :page_type
  has_many :field_groups_fields, through: :field_groups, counter_cache: :field_groups_fields_count
  has_many :fields, through: :field_groups

  has_many :annotations, dependent: :destroy
  has_many :data_entries, through: :annotations, counter_cache: :data_entries_count

  has_many :annotations_with_dimensions,
            -> {
              where.not(
                x_tl: nil,
                y_tl: nil,
                width: nil,
                height: nil
              )
              .order("observation_date asc")
            },
            class_name: 'Annotation'

  validates :page_id, uniqueness: { scope: :user_id }

  before_save :update_row_counters

  scope :completed, -> { where(complete: true) }
  scope :in_progress, -> { where(complete: false) }

  def num_rows_started
    # annotations.pluck(:observation_date).uniq.size
    started_rows_count
  end

  def num_rows_expected
    # page.num_rows_expected || 0
    expected_rows_count
  end

  def num_data_entries
    # data_entries_count
    data_entries.size
  end

  def num_data_entries_expected
    field_groups_fields_count * num_rows_expected
  end

  def percent_complete
    value = 0
    value = ((num_data_entries.to_f / num_data_entries_expected.to_f) * 100) || 0 if num_data_entries > 0 && num_data_entries_expected > 0

    precision =
      if value < 1
        2
      elsif value < 10
        3
      else
        4
      end

    BigDecimal(value, precision)
  end

  private

  def update_row_counters
    self.started_rows_count = annotations.pluck(:observation_date).uniq.size
    self.expected_rows_count = page.num_rows_expected || 0
  end
end
