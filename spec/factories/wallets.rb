# frozen_string_literal: true

FactoryBot.define do
  factory :wallet do
    sequence(:name) { |n| "Wallet_#{n}" }
    user

    trait :invalid do
      name { nil }
    end
  end
end
