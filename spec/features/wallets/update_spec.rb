# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can update the wallet' do
  given(:user) { create(:user) }
  given!(:wallet) { create(:wallet, user:) }
  given!(:another_wallet) { create(:wallet, user:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path
      click_link 'Wallets'
      click_link wallet.name
      click_link 'Edit'
    end

    scenario 'updates wallet attributes' do
      fill_in :wallet_name, with: 'Updated test wallet'
      click_button 'Update'

      expect(page).to have_content('Wallet successfully updated!')
      expect(page).to have_content('Updated test wallet')
    end

    scenario 'sees errors if provides blank name' do
      fill_in :wallet_name, with: ''
      click_button 'Update'

      expect(page).to have_content("Name can't be blank")
    end

    scenario 'sees errors if provides already used name' do
      fill_in :wallet_name, with: another_wallet.name
      click_button 'Update'

      expect(page).to have_content('Name has already been taken')
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit edit_wallet_path(wallet)

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
