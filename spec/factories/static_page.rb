require 'faker'

FactoryBot.define do
  factory :static_page do
    title { Faker::GreekPhilosophers.name }
    body { Faker::GreekPhilosophers.quote }
    slug { Faker::Internet.unique.slug }
  end
end
