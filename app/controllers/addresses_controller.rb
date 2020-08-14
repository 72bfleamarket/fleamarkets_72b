class AddressesController < ApplicationController
  before_action :set_parents, only: [:edit, :update]

  def edit
    if user_signed_in?
      @profile = current_user.profile
      @address = Address.where(user_id: current_user.id)[0]
      return
    else
      redirect_to user_path
    end
  end

  def update
    @profile = current_user.profile
    @address = Address.where(user_id: current_user.id)[0]
    if @address.update(address_params)
      return
    else
      render :edit
    end
  end

  private

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def address_params
    params.require(:address).permit(:code, :area, :city, :village, :building, :destination_first, :destination_last, :destination_first_kana, :destination_last_kana, :area_kana, :city_kana, :village_kana, :building_kana, :phone_number)
  end
end
