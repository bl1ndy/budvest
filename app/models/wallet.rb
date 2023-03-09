# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
end
