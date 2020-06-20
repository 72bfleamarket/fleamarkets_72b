class CategoriesController < ApplicationController
  def index
    @parents = Category.all.order("ancestry ASC").limit(2)
    # @parents = Category.where(ancentry: nil)
    
  end

  # def index_category_set
  #   array = [1,2,3,4,]
  #     for num in array do
  #       search_anc = Category.where('ancentry LIKE(?)',"#{num}/%")
  #       ids = []
  #       serch_anc.each do |i|
  #         ids << i[:id]
  #       end
  #       products = Product.where(category_id: ids).oder("id DESC")
  #       instance_variable_set("@cat_no#{num}",products)
  #     end
  # end

  def show
    @category = Category.find(params[:id])
    @products = Product.includes(:images).order("created_at DESC").where(category_id: @category)
  end


  private

  def product_params
    params.require(:product).permit(:name, :price, :brand, :size, :region, :condition, :postage, :shipping_day, :detal, :category_id, images_attributes: [:item, :_destroy, :id])
  end

end
