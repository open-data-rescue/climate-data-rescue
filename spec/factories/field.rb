require 'faker'

FactoryBot.define do
  factory :field do
    field_key { "field_#{Faker::Internet.uuid}" }
    data_type { 'string' }
    name_en { "Field #{Faker::Internet.uuid}" }
    full_name_en { "Field #{Faker::Internet.uuid}" }
    help_en { "Field #{Faker::Internet.uuid} is meant to capture a certain variable" }
  end
end
