require 'faker'

FactoryBot.define do
  factory :page_type do
    number = Faker::Number.unique.between(from: 1, to: 5000)
    title { "page type #{number}" }
    ledger_type { Faker::Number.unique.between(from: 100, to: 500) }
    number { Faker::Number.between(from: 1, to: 2) }

    ledger

    trait :visible do
      visible { true }
    end

    trait :fields do
      after :create do |object|
        object.field_groups = create_list :field_group, 5, :fields
      end
      after :build do |object|
        object.field_groups = build_list :field_group, 5, :fields
      end
    end
  end
end
