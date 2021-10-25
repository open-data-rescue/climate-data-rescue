require 'faker'

FactoryBot.define do
  factory :field_option do
    number = Faker::Number.unique.between(from: 1, to: 5000)
    name_en { "Field Option #{number}" }
    help_en { "Field Option #{number} is signifying such and such" }
  end
end
