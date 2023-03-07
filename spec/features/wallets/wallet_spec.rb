# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can see the page of own wallet' do
  given(:user) { create(:user) }
  given!(:wallet) { create(:wallet, user:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path
      click_link 'Wallets'
      click_link wallet.name
    end

    scenario 'sees wallet page' do
      expect(page).to have_content(wallet.name)
    end

    scenario 'sees wallet cotrols' do
      expect(page).to have_link('Back')
      expect(page).to have_link('Edit')
      expect(page).to have_button('Delete')
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit wallet_path(wallet)

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
