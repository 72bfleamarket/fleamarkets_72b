class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :edit_address, :update, :show_my_info, :show_my_profile]
  before_action :set_parents, only: [:edit, :show, :edit_address, :update, :show_my_info, :show_my_profile]

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    if user_signed_in? && current_user.id == @user.id
      @products = @user.products.order("created_at DESC")
    else
      redirect_to root_path
    end
  end

  def show_my_info
      current_user
      @address = Address.find(current_user.id)
  end

  def show_my_profile
      current_user
  end

  def edit_address
    if user_signed_in?
      @address = Address.find(current_user.id)
      return
    else
      redirect_to user_path
    end
  end

  def update_address
    @address = Address.find(current_user.id)
    if @address.valid?
      @address.update(address_params.merge(user_id: current_user.id))
    else
      render :edit_address
    end
  end

  def search
    @products = []
    if params[:likes]
      p_list = params[:likes]
      @product = "お気に入り"
      ps = Like.where(user_id: p_list).order("created_at DESC")
      ps.each do |pr|
        @products += Product.includes(:images).where(id: pr.product_id)
      end
    elsif params[:saling]
      p_list = params[:saling]
      @product = "出品中の"
      @products += User.find(p_list).saling_products.order("created_at DESC")
    elsif params[:sold]
      p_list = params[:sold]
      @product = "売却済み"
      @products += User.find(p_list).sold_products.order("created_at DESC")
    elsif params[:buyed]
      p_list = params[:buyed]
      @product = "購入済み"
      @products += User.find(p_list).buyed_products.order("created_at DESC")
    end
    partial = render_to_string(partial: "any-products", locals: { product: @products })
    puts partial
    render json: { html: partial }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def address_params
    params.require(:address).permit(:code, :area, :city, :village, :building)
  end
end
