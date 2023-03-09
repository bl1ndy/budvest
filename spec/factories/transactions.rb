# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { BigDecimal('100') }

    user

    trait :invalid do
      amount { 0 }
    end
  end
end
