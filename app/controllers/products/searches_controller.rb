class Products::SearchesController < ApplicationController
  def index
    @search_word = params[:keyword]
    @products = Product.search(@search_word).order("created_at DESC")
  end
end
