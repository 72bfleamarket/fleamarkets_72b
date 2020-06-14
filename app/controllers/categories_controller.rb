class CategoriesController < ApplicationController
  def index
    @products = Product.includes(:images).order("created_at DESC")
  end
end
