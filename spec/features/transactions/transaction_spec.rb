# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can see the page of own transaction' do
  given(:user) { create(:user) }
  given(:wallet) { create(:wallet, user:) }
  given(:category) { create(:category, user:) }
  given!(:transaction) { create(:transaction, user:, wallet:, category:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path
      click_link 'Transactions'
      click_link 'Show'
    end

    scenario 'sees transaction page' do
      expect(page).to have_content("Transaction ##{transaction.id}")
    end

    scenario 'sees transaction cotrols' do
      expect(page).to have_link('Back')
      expect(page).to have_link('Edit')
      expect(page).to have_button('Delete')
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit transaction_path(transaction)

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
