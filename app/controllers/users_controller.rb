class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update, :show_my_info]
  before_action :set_parents, only: [:edit, :show, :update, :show_my_info]

  def edit
    @profile = current_user.profile
  end

  def update
    @user = current_user
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    if user_signed_in? && current_user.id == @user.id
      @products = @user.products.order("created_at DESC")
      @profile = current_user.profile
    else
      redirect_to root_path
    end
  end

  def show_my_info
      @profile = current_user.profile
      @address = Address.find(current_user.id)
  end

  def show_my_profile
      current_user
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
    params.require(:user).permit(:name, :email, :pssword)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
