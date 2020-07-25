class CategoriesController < ApplicationController
  before_action :set_category, only: :show

  def index
    @parents = Category.where(ancestry: nil)
    @products = Product.all
    @categories = Product.includes(:images).order("created_at DESC")
  end

  def show
    @parents = Category.all.order("ancestry ASC").limit(2)
    @category = Category.find(params[:id])
    @products = Product.includes(:images).order("created_at DESC").where(category_id: @category)
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :brand, :size, :region, :condition, :postage, :shipping_day, :detal, :category_id, images_attributes: [:item, :_destroy, :id])
  end

  def set_category
    @category = Category.find(params[:id])
    if @category.has_children?
      @category_links = @category.children
    else
      @category_links = @category.siblings
    end
  end
end
