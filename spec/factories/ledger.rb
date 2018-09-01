require 'faker'

FactoryBot.define do
  factory :ledger do
    number = Faker::Number.unique.between(1, 5000)
    title { "Ledger #{number}" }
    ledger_type { Faker::Number.between(100, 500) }
  end
end
