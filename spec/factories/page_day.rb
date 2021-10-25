require 'faker'

FactoryBot.define do
  factory :page_day do
    num_observations { Faker::Number.between(from: 0, to: 9) }
  end
end
