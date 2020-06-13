class ProductsController < ApplicationController
  def index
    @products = Product.includes(:images).order("created_at DESC")
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      return
    else
      @product.images.new
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images
    @category = @product.category
    @parents = @category.root
    @children = @category.parent
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :brand, :size, :region, :condition, :postage, :shipping_day, :detal, :category_id, images_attributes: [:item])
  end
end
