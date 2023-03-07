# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WalletsController do
  let(:user) { create(:user) }
  let!(:wallet) { create(:wallet, user:) }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :index
      end

      it 'assigns @wallets to user wallets' do
        expect(assigns(:wallets)).to eq(user.wallets)
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

  describe 'GET #show' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :show, params: { id: wallet.id }
      end

      it 'assigns @wallet' do
        expect(assigns(:wallet)).to eq(wallet)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :show, params: { id: wallet.id }

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

      it 'assigns @wallet to new Wallet' do
        expect(assigns(:wallet)).to be_a_new(Wallet)
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

  describe 'GET #edit' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :edit, params: { id: wallet.id }
      end

      it 'assigns @wallet' do
        expect(assigns(:wallet)).to eq(wallet)
      end

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :edit, params: { id: wallet.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before { login(user) }

      it 'creates a new wallet' do
        expect do
          post :create, params: { wallet: attributes_for(:wallet) }
        end.to change(user.wallets, :count).by(1)
      end

      it 'redirects to wallets' do
        post :create, params: { wallet: attributes_for(:wallet) }

        expect(response).to redirect_to(wallets_path)
      end
    end

    context 'with invalid attributes' do
      before { login(user) }

      it 'does not create a new wallet' do
        expect do
          post :create, params: { wallet: attributes_for(:wallet, :invalid) }
        end.not_to change(user.wallets, :count)
      end

      it 'renders new template' do
        post :create, params: { wallet: attributes_for(:wallet, :invalid) }

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        post :create, params: { wallet: attributes_for(:wallet) }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before do
        login(user)
        patch :update, params: { id: wallet.id, wallet: { name: 'Updated wallet name' } }
      end

      it 'assigns @wallet' do
        expect(assigns(:wallet)).to eq(wallet)
      end

      it 'updates wallet attributes' do
        wallet.reload

        expect(wallet.name).to eq('Updated wallet name')
      end

      it 'redirects to the wallet' do
        expect(response).to redirect_to(wallet)
      end
    end

    context 'with invalid attributes' do
      before do
        login(user)
        patch :update, params: { id: wallet.id, wallet: attributes_for(:wallet, :invalid) }
      end

      it 'does not update wallet attributes' do
        wallet.reload

        expect(wallet.name).not_to be_nil
      end

      it 'renders edit template' do
        patch :update, params: { id: wallet.id, wallet: attributes_for(:wallet, :invalid) }

        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        patch :update, params: { id: wallet.id, wallet: { name: 'Updated wallet name' } }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when user is authenticated' do
      before do
        login(user)
        delete :destroy, params: { id: wallet.id }
      end

      it 'assigns @wallet' do
        expect(assigns(:wallet)).to eq(wallet)
      end

      it 'destroys the wallet' do
        expect(Wallet.where(id: wallet.id)).not_to exist
      end

      it 'redirects to the wallets index page' do
        expect(response).to redirect_to(wallets_path)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        delete :destroy, params: { id: wallet.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
