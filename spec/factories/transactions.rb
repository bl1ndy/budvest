# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { BigDecimal('100') }

    user
    wallet
    category
  end
end
