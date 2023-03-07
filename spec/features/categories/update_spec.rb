# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can update the category' do
  given(:user) { create(:user) }
  given!(:category) { create(:category, user:) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit root_path
      click_link 'Categories'
      click_link category.name
      click_link 'Edit'
    end

    scenario 'updates category attributes' do
      fill_in :category_name, with: 'Updated test category'
      click_button 'Update'

      expect(page).to have_content('Category successfully updated!')
      expect(page).to have_content('Updated test category')
    end

    scenario 'sees errors if invalid data provided' do
      fill_in :category_name, with: ''
      click_button 'Update'

      expect(page).to have_content("Name can't be blank")
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit edit_category_path(category)

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
