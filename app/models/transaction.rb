# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :wallet
  belongs_to :category

  validates :amount, numericality: { other_than: 0 }
end
