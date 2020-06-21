class CategoriesController < ApplicationController
  def index
    @categories = Product.includes(:images).order("created_at DESC")
  end

  def show
    @category = Category.find(params[:id])
    @products = Product.where(category_id: @category)
  end
end
