require 'faker'

FactoryBot.define do
  factory :page_type do
    number = Faker::Number.unique.between(from: 1, to: 5000)
    title { "page type #{number}" }
    ledger_type { Faker::Number.between(from: 100, to: 500) }
    number { Faker::Number.between(from: 1, to: 2) }

    ledger_id { create(:ledger).id }
  end
end
