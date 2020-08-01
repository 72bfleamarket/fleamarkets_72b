class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like

  def create
    @like = Like.create(user_id: current_user.id, product_id: @product.id)
    @likes = Like.where(product_id: params[:product_id])
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, product_id: @product.id)
    @like.destroy
    @likes = Like.where(product_id: params[:product_id])
  end

  private

  def set_like
    @product = Product.find(params[:product_id])
  end
end
