# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:wallet) }
    it { should belong_to(:category) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:amount).is_other_than(0) }
  end
end
