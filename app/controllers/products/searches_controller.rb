class Products::SearchesController < ApplicationController
  def index
    @products = Product.search(params[:keyword]).order("created_at DESC")
  end
end
