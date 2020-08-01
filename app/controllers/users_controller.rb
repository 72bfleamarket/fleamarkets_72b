class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show]

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

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
