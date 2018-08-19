require 'faker'

FactoryBot.define do
  factory :page_type do
    number = Faker::Number.unique.between(1, 5000)
    title { "page type #{number}" }
  end
end
