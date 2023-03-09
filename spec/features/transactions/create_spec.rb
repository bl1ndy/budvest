# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can create new transaction' do
  given(:user) { create(:user) }
  given!(:wallet) { create(:wallet, user:) }
  given!(:category) { create(:category, user:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path
      click_link 'Transactions'
      click_link 'Create new transaction'
    end

    scenario 'creates new transaction' do
      fill_in :transaction_amount, with: '15000'
      click_button 'Create'

      expect(page).to have_content('Transaction successfully created!')
      expect(page).to have_content('15000.0')
    end

    scenario 'sees errors if provides amount 0' do
      fill_in :transaction_amount, with: '0'
      click_button 'Create'

      expect(page).to have_content('Amount must be other than 0')
    end

    scenario 'sees errors if provides blank amount' do
      click_button 'Create'

      expect(page).to have_content('Amount is not a number')
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit new_transaction_path

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
