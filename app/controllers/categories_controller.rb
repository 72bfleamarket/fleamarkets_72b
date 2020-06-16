class CategoriesController < ApplicationController
  def index
    @products = Product.includes(:images).order("created_at DESC")
    @images = Image.order(id: "DESC")
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
end
