# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    account
    first_name { FFaker::NameUA.first_name }
    last_name { FFaker::NameUA.last_name }
    phone { FFaker::PhoneNumberUA.international_mobile_phone_number }
  end
end
