# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController do
  let(:user) { create(:user) }
  let!(:category) { create(:category, user:) }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :index
      end

      it 'assigns @categories to user categories' do
        expect(assigns(:categories)).to eq(user.categories)
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :index

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :new
      end

      it 'assigns @category to new category' do
        expect(assigns(:category)).to be_a_new(Category)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :new

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :show, params: { id: category.id }
      end

      it 'assigns @category' do
        expect(assigns(:category)).to eq(category)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :show, params: { id: category.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :edit, params: { id: category.id }
      end

      it 'assigns @category' do
        expect(assigns(:category)).to eq(category)
      end

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :edit, params: { id: category.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before { login(user) }

      it 'creates a new category' do
        expect do
          post :create, params: { category: attributes_for(:category) }
        end.to change(user.categories, :count).by(1)
      end

      it 'redirects to categories' do
        post :create, params: { category: attributes_for(:category) }

        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid attributes' do
      before { login(user) }

      it 'does not create a new category' do
        expect do
          post :create, params: { category: attributes_for(:category, :invalid) }
        end.not_to change(user.categories, :count)
      end

      it 'renders new template' do
        post :create, params: { category: attributes_for(:category, :invalid) }

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        post :create, params: { category: attributes_for(:category) }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before do
        login(user)
        patch :update, params: { id: category.id, category: { name: 'Updated category name' } }
      end

      it 'assigns @category' do
        expect(assigns(:category)).to eq(category)
      end

      it 'updates category attributes' do
        category.reload

        expect(category.name).to eq('Updated category name')
      end

      it 'redirects to the category' do
        expect(response).to redirect_to(category)
      end
    end

    context 'with invalid attributes' do
      before do
        login(user)
        patch :update, params: { id: category.id, category: attributes_for(:category, :invalid) }
      end

      it 'does not update category attributes' do
        category.reload

        expect(category.name).not_to be_nil
      end

      it 'renders edit template' do
        patch :update, params: { id: category.id, category: attributes_for(:category, :invalid) }

        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        patch :update, params: { id: category.id, category: { name: 'Updated category name' } }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is authenticated' do
      before do
        login(user)
        delete :destroy, params: { id: category.id }
      end

      it 'assigns @category' do
        expect(assigns(:category)).to eq(category)
      end

      it 'destroys the category' do
        expect(Category.where(id: category.id)).not_to exist
      end

      it 'redirects to the categories index page' do
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        delete :destroy, params: { id: category.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
