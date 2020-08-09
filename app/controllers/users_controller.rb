class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :edit_address, :update]
  before_action :set_parents, only: [:edit, :show, :edit_address, :update]

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
      @user = User.find(current_user.id)
      return
    else
      redirect_to user_path
    end
  end

  def update_address
    if @address.valid?
      @address = Address.update(address_params.merge(user_id: @user.id))
      @address.save
      @user = user.update(user_edit_params)
      @user.save
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

  def address_params
    params.require(:address).permit(:code, :area, :city, :village, :building)
  end

  def user_edit_params
    params.require(:user).permit(:first_name, :last_name, :first_kana, :last_kana)
  end
end
