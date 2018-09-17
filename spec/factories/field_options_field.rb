require 'faker'

FactoryBot.define do
  factory :field_options_field do
    sort_order { Faker::Number.unique.between(-8388607, 8388607) }
    field_id { create(:field).id }
    field_option_id { create(:field_option).id }
  end
end
