# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can delete the transaction', :js do
  given(:user) { create(:user) }
  given(:wallet) { create(:wallet, user:) }
  given(:category) { create(:category, user:) }
  given!(:transaction) { create(:transaction, user:, wallet:, category:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit transaction_path(transaction)
    end

    scenario 'deletes the transaction' do
      accept_confirm do
        click_button 'Delete'
      end

      expect(page).to have_content('Transaction successfully deleted!')
      expect(page).not_to have_content(transaction.amount)
    end
  end
end
