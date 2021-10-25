require 'faker'

FactoryBot.define do
  factory :data_entry do
    page
    field
    annotation
    user

    data_type { 'string' }
    value { Faker::Number.between(from: 1, to: 500) }
  end
end
