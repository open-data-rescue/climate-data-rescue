require 'faker'

FactoryBot.define do
  factory :page_day do
    num_observations { Faker::Number.between(0, 9) }
  end
end
