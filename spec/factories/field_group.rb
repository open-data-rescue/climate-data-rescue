require 'faker'

FactoryBot.define do
  factory :field_group do
    number = Faker::Number.unique.between(from: 1, to: 5000)
    colour_class { %w(red-group pink-group purple-group blue-group cyan-group green-group yellow-group orange-group)[Faker::Number.between(from: 0, to: 7)] }
    name_en { "Field group #{number}" }
    display_name_en { "Field group #{number} display name" }
    help_en { "Field group #{number} is meant to group certasin fields" }

    trait :fields do
      after :create do |object|
        object.fields = create_list :field, 5
      end
      after :build do |object|
        object.fields = build_list :field, 5
      end
    end
  end
end
