# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]　/デフォルト記載
  # before_action :configure_account_update_params, only: [:update]　/デフォルト記載
  before_action :set_parents, only: [:edit, :update]

  def new
    @user = User.new
  end

  def new_user
    @user = User.new
  end

  def create_user
    if params[:sns_auth] == "true"
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    params[:user][:birthday] = birthday_join
    @user = User.new(sign_up_params)
    @address = Address.new
    if @user.valid?
      session["devise.regist_data"] = { user: @user.attributes }
      session["devise.regist_data"][:user]["password"] = params[:user][:password]
      session["devise.regist_data"][:user]["password_confirmation"] = params[:user][:password_confirmation]

      render :new_address
    else
      render :new_user
    end
  end

  def new_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    if @address.valid?
      @user.save
      @address = Address.new(address_params.merge(user_id: @user.id))
      @address.save
      session["devise.regist_data"]["user"].clear
      sign_in(:user, @user)
    else
      render :new_address
    end
  end

  def edit
    @profile = current_user.profile
    @user = User.find(current_user.id)
  end

  # PUT /resource/password
  def update
    @user = User.find(current_user.id)
    if current_user.update(user_params)
      # binding.pry
      return
    else
      render :edit
    end
  end

  protected

  def birthday_join
    @date = params[:birthday]
    if @date.values[0].empty?
      return
    elsif @date.values[1].empty?
      return
    elsif @date.values[2].empty?
      return
    end
    Date.new(@date.values[0].to_i, @date.values[1].to_i, @date.values[2].to_i)
  end

  # If you have extra params to permit, append them to the sanitizer. /デフォルト記載
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password, :email, :first_name, :last_name, :first_kana, :last_kana, :birthday])
  end

  # def sign_up_params　/デフォルト記載
  #   params.require(:user).permit(:name, :email, :first_name,:last_name, :first_kana, :last_kana, :birthday)
  # end

  def address_params
    params.require(:address).permit(:code, :area, :city, :village, :building, :destination_first, :destination_last, :destination_first_kana, :destination_last_kana, :area_kana, :city_kana, :village_kana, :building_kana, :phone_number)
  end

  def profile_params
    params.require(:user).permit(:profile, :icons, :password)
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
