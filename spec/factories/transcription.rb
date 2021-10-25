require 'faker'

FactoryBot.define do
  factory :transcription do
    page
    user

    trait :stale do
      updated_at { Date.current - (Page::STALE_DURATION + 1.week) }
    end

    trait :finished do
      complete { true }
    end
  end
end
