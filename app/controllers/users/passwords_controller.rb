# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # before_action :set_user, only: [:edit, :update]
  before_action :set_parents, only: [:edit, :update]
  before_action :authenticate_user!
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    @user = User.find(current_user.id)
    
    binding.pry
    
  end

  # PUT /resource/password
  def update
    if current_user.update_with_password(user_params)
        redirect_to account_path
    else
        render :edit
    end
end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  protected

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
end

  # def set_user
  #   @user = User.find(params[:id])
  # end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
