require 'faker'

FactoryBot.define do
  factory :page_types_field_group do
    sort_order { Faker::Number.unique.between(-8388607, 8388607) }
  end
end
