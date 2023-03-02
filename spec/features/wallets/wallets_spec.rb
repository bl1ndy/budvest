# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can see the list of all own wallets' do
  given(:user) { create(:user) }
  given!(:wallets) { create_list(:wallet, 5, user:) }
  given!(:another_wallet) { create(:wallet, user: create(:user)) }

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'sees own wallets list' do
      visit root_path
      click_link 'Wallets'

      wallets.each { |wallet| expect(page).to have_content(wallet.name) }
      expect(page).not_to have_content(another_wallet.name)
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit root_path
      click_link 'Wallets'

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
