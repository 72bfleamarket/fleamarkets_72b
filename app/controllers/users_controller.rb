class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show]
  before_action :set_parents, only: [:edit, :show]

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

  def edit_address
    if user_signed_in?
      @address = Address.find(current_user.id)
      return
    else
      redirect_to product_path
    end
  end

  def update_address
    @address = Address.find(current_user.id)
    if @address.valid?
      @address.save
    else
      render :edit_address
    end
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
end
