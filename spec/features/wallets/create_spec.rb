# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can create new wallet' do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit root_path
      click_link 'Wallets'
      click_link 'Create new wallet'
    end

    scenario 'creates new wallet' do
      fill_in :wallet_name, with: 'Test wallet'
      click_button 'Create'

      expect(page).to have_content('Wallet successfully created!')
      expect(page).to have_content('Test wallet')
    end

    scenario 'sees errors if invalid data provided' do
      click_button 'Create'

      expect(page).to have_content("Name can't be blank")
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit new_wallet_path

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
