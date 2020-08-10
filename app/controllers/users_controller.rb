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

  def search
    if params[:likes]
      like_list = params[:likes]
      @likes = []
      likes = Like.where(user_id: like_list).order("created_at DESC")
      likes.each do |like|
        @likes += Product.includes(:images).where(id: like.product_id)
      end
      partial = render_to_string(partial: "like-products", locals: { likes: @likes })
    end
    puts partial
    render json: { html: partial }
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
