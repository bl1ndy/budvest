# frozen_string_literal: true

class WalletsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wallets = current_user.wallets
  end

  def show
    wallet
  end

  def new
    @wallet = current_user.wallets.build
  end

  def edit
    wallet
  end

  def create
    @wallet = current_user.wallets.build(wallet_params)

    if @wallet.save
      flash[:success] = t('.success')
      redirect_to wallets_path
    else
      render :new
    end
  end

  def update
    if wallet.update(wallet_params)
      flash[:success] = t('.success')
      redirect_to wallet
    else
      render :edit
    end
  end

  def destroy
    return unless wallet.destroy

    flash[:success] = t('.success')
    redirect_to wallets_path
  end
end

private

def wallet
  @wallet ||= Wallet.find(params[:id])
end

def wallet_params
  params.require(:wallet).permit(:name)
end
