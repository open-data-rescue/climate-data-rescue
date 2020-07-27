require 'faker'

FactoryBot.define do
  factory :ledger do
    number = Faker::Number.unique.between(from: 1, to: 5000)
    title { "Ledger #{number}" }
    ledger_type { Faker::Number.between(from: 100, to: 500) }
  end
end
