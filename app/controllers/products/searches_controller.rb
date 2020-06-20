class Products::SearchesController < ApplicationController
  def index
    @products = Product.search(params[:keyword])
  end
end
