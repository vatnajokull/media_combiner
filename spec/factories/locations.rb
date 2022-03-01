# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    city { FFaker::AddressUA.city }
    street { FFaker::AddressUA.street_name }
    building_number { FFaker::AddressUA.building_number }
    appartment_number { FFaker::AddressUA.appartment_number }
    zip_code { FFaker::AddressUA.zip_code }
  end
end
