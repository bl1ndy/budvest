# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category do
  before do
    create(:user)
    create(:category, :income)
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:transactions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(%i[category_type user_id]).case_insensitive }
  end
end
