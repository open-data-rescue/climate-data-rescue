class Field < ApplicationRecord
  include TranslationHelpers

  MEASUREMENT_TYPE_OPTIONS = %w[
    orginal_observation mean summary number_of_days statistic
    corrected difference estimated adjusted calculated other
  ].freeze

  ODR_TYPE_OPTIONS = %w[
    p mslp ta ww dd pr rr atb au c cd ch cv e h hd hv nl rh o3 rd rtb rte
    sd skc tarange tb td tdb Tgn Tn Tx Txs w1 wf ws ww_remarks taNW TnNW TxNW
  ].freeze

  translates :name, :full_name, :help,
             fallbacks_for_empty_translations: true,
             touch: true
  globalize_accessors

  has_many :field_groups_fields, dependent: :destroy
  has_many :field_groups, through: :field_groups_fields

  has_many :page_types, through: :field_groups
  
  has_many :field_options_fields, dependent: :destroy
  has_many :field_options, -> { order("field_options_fields.sort_order asc") }, through: :field_options_fields
  has_many :data_entries

  validates :name,
            presence: true
  validates :full_name,
            presence: true
  validates :help,
            presence: true
  validates :field_key,
            presence: true,
            uniqueness: true
  validates :data_type,
            presence: true,
            inclusion: {
              in: %w(string integer decimal)
            }
  validates :measurement_type,
            inclusion: {
              in: MEASUREMENT_TYPE_OPTIONS
            },
            allow_blank: true,
            allow_nil: true
  validates :odr_type,
            inclusion: {
              in: ODR_TYPE_OPTIONS
            },
            allow_blank: true,
            allow_nil: true

  before_destroy :check_for_data_entries

  private 

  def check_for_data_entries
    if data_entries.any?
      raise "Can't delete a field that has data entered"
    end
  end
  
end
