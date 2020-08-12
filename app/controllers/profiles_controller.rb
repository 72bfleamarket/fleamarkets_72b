class ProfilesController < ApplicationController
  before_action :set_parents, only: [:new, :edit]

  def new
    if user_signed_in?
      @user = User.find(current_user.id)
      @profile = Profile.all
      if @user.profile
        @profile = @user.profile
      end
    end
  end

  def create
      profile = Profile.find_or_create_by(user_id: current_user.id)
      profile.update(profile_params)
  end
  
  private
  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def profile_params
    params.permit(:profile, :icon)
  end
  
end
