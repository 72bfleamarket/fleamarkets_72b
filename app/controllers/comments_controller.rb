class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    @sellerId = @comment.product.user_id
    respond_to do |format|
      format.html { redirect_to product_path(params[:product_id])}
      format.json
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])
  end

end
