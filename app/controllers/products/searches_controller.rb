class Products::SearchesController < ApplicationController
  # before_action :set_search

  def index

    @parents = Category.where(ancestry: nil)
    @products = []
    categories = []
    pp = []
    aaa = []

    @search = Product.ransack(params[:q])
    if params[:keyword]
      @search_word = params[:keyword]
      nil if @search_word == ""
      split_keyword = @search_word.to_s.split(/[[:blank:]]+/)

      split_keyword.each do |keyword|
        next if keyword == ""
        @products += Product.where("name LIKE(?) OR brand LIKE(?)", "%#{keyword}%", "%#{keyword}%").order(created_at: :desc)
      end

      split_keyword.each do |keyword|
        categorys = Category.where("name LIKE(?)", "%#{keyword}%")
        categorys.each do |category|
          if category.has_children?
            category_ids = category.descendants
            categories.push(Product.includes(:images).order("created_at DESC").where(category_id: category_ids)).flatten!
          else
            categories.push(Product.includes(:images).order("created_at DESC").where(category_id: category)).flatten!
          end
        end
      end
      @products.push(categories).flatten!
    else
      @products += @search.result
      



      # @products.each do |cate|

      # @children = cate.category.parent
      # @parent = @children.parent
      # end

      # @products += @children
      # @products += @parent
      

      #   if cate.has_parent?
      #     cate_ids = cate.ancestors
      #     categories.push(Product.includes(:images).order("created_at DESC").where(category_id: cate_ids)).flatten!
      #   else
      #     categories.push(Product.includes(:images).order("created_at DESC").where(category_id: cate)).flatten!
      #   end
      # end

      
      # binding.pry
      

      # @c = Category.cwith_keywords(params.dig(:q, :keywords)).ransack(params[:q])
      # # binding.pry
      # cates = @c.result(distinct: true).order(created_at: "DESC")
      # cates.each do |cate|
      #   if cate.has_children?
      #     cate_ids = cate.descendants
      #     categories.push(Product.includes(:images).order("created_at DESC").where(category_id: cate_ids)).flatten!
      #   else
      #     categories.push(Product.includes(:images).order("created_at DESC").where(category_id: cate)).flatten!
      #   end
      # end
      # @search = Product.with_keywords(params.dig(:q, :keywords)).ransack(params[:q])
      # aaa += @search.result(distinct: true).order(created_at: "DESC")
      # # binding.pry
      # aaa += categories
      # aaa.select { |a| aaa.count(a) > 1 }.uniq
      # @products += aaa
      # @products.uniq!

      # newProduct = []
      # @products.each do |p|
      #   if p.price > lessthan
      #     newProduct << p
      #   end

      #   if p.price < greaterthan
      #   end
      # end
    end

    # private

    # def set_search
    #   @searchs = Category.ransack(params[:q])
    # end
  end
end
