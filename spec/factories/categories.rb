# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category_#{n}" }
    user

    trait :invalid do
      name { nil }
    end

    trait :income do
      category_type { :income }
    end

    trait :spending do
      category_type { :spending }
    end
  end
end
