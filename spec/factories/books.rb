# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    category
    title { FFaker::Book.genre }
    description { FFaker::Book.description }
    pages { rand(30..1700) }
    publishing_year { rand(1900..2021) }

    trait :with_authors do
      transient do
        authors_number { 1 }
      end

      after :create do |book, evaluator|
        create_list(:authors_book, evaluator.authors_number, book: book)
      end
    end
  end
end
