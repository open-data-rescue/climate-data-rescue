require 'faker'

FactoryBot.define do
  factory :annotation do
    observation_date { DateTime.now }
    date_time_id { I18n.l(DateTime.now, format: :short) }

    page_id { create(:page).id }
    field_group_id { create(:field_group).id }
    transcription_id { create(:transcription).id }
  end
end
