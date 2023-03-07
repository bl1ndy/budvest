# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :user

  enum category_type: { income: 0, spending: 1 }

  validates :name, presence: true, uniqueness: { scope: %i[category_type user_id], case_sensitive: false }
end
