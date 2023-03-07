# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can see the list of all own categories' do
  given(:user) { create(:user) }
  given!(:categories) { create_list(:category, 5, user:) }
  given!(:another_category) { create(:category, user: create(:user)) }

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'sees own categories list' do
      visit root_path
      click_link 'Categories'

      categories.each { |category| expect(page).to have_content(category.name) }
      expect(page).not_to have_content(another_category.name)
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit root_path
      click_link 'Categories'

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
