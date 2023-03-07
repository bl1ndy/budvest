# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can see the page of own category' do
  given(:user) { create(:user) }
  given!(:category) { create(:category, user:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path
      click_link 'Categories'
      click_link category.name
    end

    scenario 'sees category page' do
      expect(page).to have_content(category.name)
      expect(page).to have_content(category.category_type.capitalize)
    end

    scenario 'sees category cotrols' do
      expect(page).to have_link('Back')
      expect(page).to have_link('Edit')
      expect(page).to have_button('Delete')
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit category_path(category)

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
