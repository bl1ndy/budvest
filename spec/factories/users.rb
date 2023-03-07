# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    password { '12345678' }
    confirmed_at { Time.zone.now }
  end

  trait :unconfirmed do
    confirmed_at { nil }
  end
end
