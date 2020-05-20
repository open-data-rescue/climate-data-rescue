require 'faker'

FactoryBot.define do
  factory :field_group do
    number = Faker::Number.unique.between(from: 1, to: 5000)
    colour_class { FieldGroup::COLOUR_CLASSES[Faker::Number.between(from: 0, to: 7)] }
    name_en { "Field group #{number}" }
    display_name_en { "Field group #{number} display name" }
    help_en { "Field group #{number} is meant to group certasin fields" }
  end
end
