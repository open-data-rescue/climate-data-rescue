require 'faker'

FactoryBot.define do
  factory :field do
    number = Faker::Number.unique.between(1, 5000)
    field_key { "field_#{number}" }
    data_type { %w(string integer decimal)[Faker::Number.between(0, 2)] }
    name_en { "Field #{number}" }
    full_name_en { "Field #{number}" }
    help_en { "Field #{number} is meant to capture a certain variable" }
  end
end
