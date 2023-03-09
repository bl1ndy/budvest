# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can see the list of all own transactions' do
  given(:user) { create(:user) }
  given(:wallet) { create(:wallet, user:) }
  given(:category) { create(:category, user:) }
  given!(:transaction) { create(:transaction, user:, wallet:, category:) }
  given!(:another_transaction) do
    create(:transaction, amount: 150, user: create(:user), wallet: create(:wallet), category: create(:category))
  end

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'sees own transactions list' do
      visit root_path
      click_link 'Transactions'

      expect(page).to have_content(transaction.amount)
      expect(page).not_to have_content(another_transaction.amount)
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit root_path
      click_link 'Transactions'

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
