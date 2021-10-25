require 'faker'

FactoryBot.define do
  factory :field_options_field do
    sort_order { Faker::Number.unique.between(from: -8388607, to: 8388607) }
    field
    field_option
  end
end
