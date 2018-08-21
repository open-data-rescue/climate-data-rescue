require 'faker'

FactoryBot.define do
  factory :data_entry do
    association :page
    association :field
    association :annotation
    association :user

    data_type { 'string' }
    value { Faker::Number.between(1, 500) }
  end
end
