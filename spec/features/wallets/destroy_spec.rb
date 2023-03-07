# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can delete the wallet', :js do
  given(:user) { create(:user) }
  given!(:wallet) { create(:wallet, user:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit wallet_path(wallet)
    end

    scenario 'deletes the wallet' do
      accept_confirm do
        click_button 'Delete'
      end

      expect(page).to have_content('Wallet successfully deleted!')
      expect(page).not_to have_content(wallet.name)
    end
  end
end
