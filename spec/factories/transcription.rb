require 'faker'

FactoryBot.define do
  factory :transcription do
    association :page
    association :user
  end
end
