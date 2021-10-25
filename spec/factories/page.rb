require 'faker'

FactoryBot.define do
  factory :page do
    page_type

    trait :image do
      image do
        Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', '1491_110_11_1879-06-01_1879-06-03_1.jpg'), 'image/jpg')
      end
    end

    trait :transcribeable do
      association :page_type, factory: [:page_type, :visible, :fields]
      done { false }
      visible { true }
    end

    trait :transcription do
      after :create do |object|
        create :transcription, page: object
      end
      after :build do |object|
        build :transcription, page: object
      end
    end

    trait :finished_transcription do
      after :create do |object|
        create :transcription, :finished, :stale, page: object
      end
      after :build do |object|
        build :transcription, :finished, :stale, page: object
      end
    end

    trait :stale_transcription do
      after :create do |object|
        create :transcription, :stale, page: object
      end
      after :build do |object|
        build :transcription, :stale, page: object
      end
    end
  end
end
