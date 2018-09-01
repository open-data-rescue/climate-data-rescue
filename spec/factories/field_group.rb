require 'faker'

FactoryBot.define do
  factory :field_group do
    number = Faker::Number.unique.between(1, 5000)
    colour_class { %w(red-group pink-group purple-group blue-group cyan-group green-group yellow-group orange-group)[Faker::Number.between(0, 7)] }
    name_en { "Field group #{number}" }
    display_name_en { "Field group #{number} display name" }
    help_en { "Field group #{number} is meant to group certasin fields" }
  end
end
