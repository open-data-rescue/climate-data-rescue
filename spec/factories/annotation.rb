require 'faker'

FactoryBot.define do
  factory :annotation do
    association :page
    association :field_group
    observation_date { DateTime.now }
    date_time_id { I18n.l(DateTime.now, format: :short) }
  end
end
