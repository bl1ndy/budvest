# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "Wallet_#{n}"
  end

  factory :wallet do
    name
    user

    trait :invalid do
      name { nil }
    end
  end
end
