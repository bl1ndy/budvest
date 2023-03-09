# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can update the transaction' do
  given(:user) { create(:user) }
  given(:wallet) { create(:wallet, user:) }
  given(:category) { create(:category, user:) }
  given!(:transaction) { create(:transaction, user:, wallet:, category:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path
      click_link 'Transactions'
      click_link 'Edit'
    end

    scenario 'updates transaction attributes' do
      fill_in :transaction_amount, with: '15000'
      click_button 'Update'

      expect(page).to have_content('Transaction successfully updated!')
      expect(page).to have_content('15000.0')
    end

    scenario 'sees errors if provides amount 0' do
      fill_in :transaction_amount, with: '0'
      click_button 'Update'

      expect(page).to have_content('Amount must be other than 0')
    end

    scenario 'sees errors if provides blank amount' do
      fill_in :transaction_amount, with: ''
      click_button 'Update'

      expect(page).to have_content('Amount is not a number')
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit edit_transaction_path(transaction)

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
