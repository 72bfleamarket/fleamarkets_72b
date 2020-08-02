class Products::SearchesController < ApplicationController
  def index
    @search_word = params[:keyword]
    redirect_to root_path if @search_word == ''
    split_keyword = @search_word.split(/[[:blank:]]+/)

    @products = [] 
    split_keyword.each do |keyword|
      next if keyword == ''
      @products += Product.where('name LIKE(?)', "%#{keyword}%").order(created_at: :desc)
    end 
    @products.uniq! #重複した商品を削除する

    @categories = Category.all
    @parents = Category.where(ancestry: nil)
  end
end
