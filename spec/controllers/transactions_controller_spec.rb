# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController do
  let(:user) { create(:user) }
  let(:wallet) { create(:wallet, user:) }
  let(:category) { create(:category, user:) }
  let!(:transaction) { create(:transaction, user:, wallet:, category:) }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :index
      end

      it 'assigns @transactions to user transactions' do
        expect(assigns(:transactions)).to eq(user.transactions)
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

      it 'assigns @transaction to new transaction' do
        expect(assigns(:transaction)).to be_a_new(Transaction)
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
        get :show, params: { id: transaction.id }
      end

      it 'assigns @transaction' do
        expect(assigns(:transaction)).to eq(transaction)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :show, params: { id: transaction.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is authenticated' do
      before do
        login(user)
        get :edit, params: { id: transaction.id }
      end

      it 'assigns @transaction' do
        expect(assigns(:transaction)).to eq(transaction)
      end

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :edit, params: { id: transaction.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before { login(user) }

      it 'creates a new transaction' do
        expect do
          post :create, params: {
            transaction: attributes_for(:transaction).merge(
              wallet_id: wallet.id,
              category_id: category.id
            )
          }
        end.to change(user.transactions, :count).by(1)
      end

      it 'redirects to transactions' do
        post :create, params: {
          transaction: attributes_for(:transaction).merge(
            wallet_id: wallet.id,
            category_id: category.id
          )
        }

        expect(response).to redirect_to(transactions_path)
      end
    end

    context 'with invalid attributes' do
      before { login(user) }

      it 'does not create a new transaction' do
        expect do
          post :create, params: { transaction: attributes_for(:transaction, :invalid) }
        end.not_to change(user.transactions, :count)
      end

      it 'renders new template' do
        post :create, params: { transaction: attributes_for(:transaction, :invalid) }

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        post :create, params: { transaction: attributes_for(:transaction) }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before do
        login(user)
        patch :update, params: { id: transaction.id, transaction: { amount: 150 } }
      end

      it 'assigns @transaction' do
        expect(assigns(:transaction)).to eq(transaction)
      end

      it 'updates transaction attributes' do
        transaction.reload

        expect(transaction.amount).to eq(BigDecimal('150'))
      end

      it 'redirects to the transaction' do
        expect(response).to redirect_to(transaction)
      end
    end

    context 'with invalid attributes' do
      before do
        login(user)
        patch :update, params: { id: transaction.id, transaction: attributes_for(:transaction, :invalid) }
      end

      it 'does not update transaction attributes' do
        transaction.reload

        expect(transaction.amount).not_to eq(0)
      end

      it 'renders edit template' do
        patch :update, params: { id: transaction.id, transaction: attributes_for(:transaction, :invalid) }

        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        patch :update, params: { id: transaction.id, transaction: attributes_for(:transaction) }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is authenticated' do
      before do
        login(user)
        delete :destroy, params: { id: transaction.id }
      end

      it 'assigns @transaction' do
        expect(assigns(:transaction)).to eq(transaction)
      end

      it 'destroys the transaction' do
        expect(Transaction.where(id: transaction.id)).not_to exist
      end

      it 'redirects to the transactions index page' do
        expect(response).to redirect_to(transactions_path)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        delete :destroy, params: { id: transaction.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
