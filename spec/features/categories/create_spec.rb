# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can create new category' do
  given(:user) { create(:user) }
  given!(:category) { create(:category, user:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path
      click_link 'Categories'
      click_link 'Create new category'
    end

    scenario 'creates new category' do
      fill_in :category_name, with: 'Test category'
      click_button 'Create'

      expect(page).to have_content('Category successfully created!')
      expect(page).to have_content('Test category')
    end

    scenario 'sees errors if provides blank name' do
      click_button 'Create'

      expect(page).to have_content("Name can't be blank")
    end

    scenario 'sees errors if provides already used name' do
      fill_in :category_name, with: category.name
      click_button 'Create'

      expect(page).to have_content('Name has already been taken')
    end
  end

  describe 'Guest' do
    scenario 'redirects to sign in' do
      visit new_category_path

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
