# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.order(created_at: :desc)
  end

  def show
    transaction
  end

  def new
    @transaction = current_user.transactions.build
  end

  def edit
    transaction
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)

    if @transaction.save
      flash[:success] = t('.success')
      redirect_to transactions_path
    else
      render :new
    end
  end

  def update
    if transaction.update(transaction_params)
      flash[:success] = t('.success')
      redirect_to transaction
    else
      render :edit
    end
  end

  def destroy
    return unless transaction.destroy

    flash[:success] = t('.success')
    redirect_to transactions_path
  end

  private

  def transaction
    @transaction ||= Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :wallet_id, :category_id)
  end
end
