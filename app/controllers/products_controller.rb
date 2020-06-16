class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]

  def index
    @products = Product.includes(:images).order("created_at DESC")
    @images = Image.limit(3).order(id: "DESC")

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

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def show
    @images = @product.images
    @category = @product.category
    @parents = @category.root
    @children = @category.parent
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :brand, :size, :region, :condition, :postage, :shipping_day, :detal, :category_id, images_attributes: [:item, :_destroy, :id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
