class Products::SearchesController < ApplicationController
  def index
    @search_word = params[:keyword]
    redirect_to root_path if @search_word == ""
    split_keyword = @search_word.split(/[[:blank:]]+/)

    @products = []
    split_keyword.each do |keyword|
      next if keyword == ""
      @products += Product.all.where("name LIKE(?) OR brand LIKE(?)", "%#{keyword}%", "%#{keyword}%").order(created_at: :desc)
    end

    @category = []
    split_keyword.each do |keyword|
      categorys = Category.all.where("name LIKE(?)", "%#{keyword}%")
      categorys.each do |category|
        if category.has_children?
          category_ids = category.descendants
          @category.push(Product.includes(:images).order("created_at DESC").where(category_id: category_ids)).flatten!
        else
          @category.push(Product.includes(:images).order("created_at DESC").where(category_id: category)).flatten!
        end
      end
    end
    @products.push(@category).flatten!
    @products.uniq! #重複した商品を削除する

    @categories = Category.all
    @parents = Category.where(ancestry: nil)
  end
end
