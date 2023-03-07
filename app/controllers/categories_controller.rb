# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories.order(:created_at)
  end

  def show
    category
  end

  def new
    @category = current_user.categories.build
  end

  def edit
    category
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      flash[:success] = t('.success')
      redirect_to categories_path
    else
      render :new
    end
  end

  def update
    if category.update(category_params)
      flash[:success] = t('.success')
      redirect_to category
    else
      render :edit
    end
  end

  def destroy
    return unless category.destroy

    flash[:success] = t('.success')
    redirect_to categories_path
  end

  private

  def category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :category_type)
  end
end
