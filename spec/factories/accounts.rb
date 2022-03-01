# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    provider { :email }
    uuid { nil }
    user { nil }
  end
end
