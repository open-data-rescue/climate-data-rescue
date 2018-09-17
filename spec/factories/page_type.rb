require 'faker'

FactoryBot.define do
  factory :page_type do
    number = Faker::Number.unique.between(1, 5000)
    title { "page type #{number}" }
    ledger_type { Faker::Number.between(100, 500) }
    number { Faker::Number.between(1, 2) }

    ledger_id { create(:ledger).id }
  end
end
