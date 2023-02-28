# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wallet do
  before do
    create(:user)
    create(:wallet)
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
  end
end
