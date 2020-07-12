class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]
  before_action :move_to_index, except: [:index, :show]

  def index
    @search = Product.ransack(params[:q])
    @products = @search.result.includes(:images).order("created_at DESC")
    if user_signed_in?
      @user = User.find(current_user.id)
    end
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
    if user_signed_in? && current_user.id == @product.user_id
      return
    else
      redirect_to product_path
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def show
    if user_signed_in?
      @user = User.find(current_user.id)
    end
    @images = @product.images
    @category = @product.category
    @parents = @category.root
    @children = @category.parent
  end

  def destroy
    if @product.destroy
      redirect_to root_path
    else
      redirect_to product_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :brand, :size, :prefecture_id, :condition, :postage, :shipping_day, :detal, :category_id, :buyer_id, images_attributes: [:item, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def move_to_index
    redirect_to user_session_path unless user_signed_in?
  end
end
