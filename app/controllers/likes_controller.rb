class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like

  def create
    @user = current_user
    @like = Like.create(user_id: @user.id, product_id: @product.id)
    @likes = Like.where(product_id: params[:product_id])
  end

  def destroy
    @user = current_user
    @like = Like.find_by(user_id: @user.id, product_id: @product.id)
    @like.destroy
    @likes = Like.where(product_id: params[:product_id])
  end

  private

  def set_like
    @product = Product.find(params[:product_id])
  end
end
