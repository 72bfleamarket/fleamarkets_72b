class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :first_name, :last_name, :first_kana, :last_kana, :birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:icons, :profile])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:icons, :profile])
  end

  def production?
    Rails.env.production?
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
