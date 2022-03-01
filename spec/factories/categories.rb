# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    title { FFaker::Book.genre }
    description { FFaker::Book.description }
  end
end
