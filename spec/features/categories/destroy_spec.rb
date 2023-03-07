# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can delete the category', :js do
  given(:user) { create(:user) }
  given!(:category) { create(:category, user:) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit category_path(category)
    end

    scenario 'deletes the category' do
      accept_confirm do
        click_button 'Delete'
      end

      expect(page).to have_content('Category successfully deleted!')
      expect(page).not_to have_content(category.name)
    end
  end
end
