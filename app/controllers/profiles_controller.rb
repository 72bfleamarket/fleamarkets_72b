class ProfilesController < ApplicationController
  before_action :set_parents, only: [:new, :edit, :update, :create]

  def new
    if user_signed_in?
      @profile = Profile.new
      @user = User.find(current_user.id)
    end
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to edit_profile_path(@profile)
    else
      render :new
    end
  end

  def edit
    if user_signed_in?
      @user = User.find(current_user.id)
      @profile = Profile.find_by(user_id: current_user.id)
    end
  end

  def update
    @user = User.find(current_user.id)
    @profile = Profile.find_by(user_id: current_user.id)
    if @profile.update(profile_params)
      return
    else
      render :edit
    end
  end

  private

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def profile_params
    params.require(:profile).permit(:profile, :icon, :remove_icon).merge(user_id: current_user.id)
  end
end
