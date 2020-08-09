class Products::SearchesController < ApplicationController
  before_action :set_search

  def index
    @parents = Category.where(ancestry: nil)
    @products = []
    categories = []
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
      if params.dig(:q, :keywords).present?
        cates = Category.with_keywords(params.dig(:q, :keywords))
        cates.each do |cate|
          if cate.has_children?
            cate_ids = cate.descendants
            @c = Product.includes(:images).order("created_at DESC").where(category_id: cate_ids).ransack(params[:q])
            categories += @c.result(distinct: true)
          else
            @c = Product.includes(:images).order("created_at DESC").where(category_id: cate).ransack(params[:q])
            categories += @c.result(distinct: true)
          end
        end
        @products.push(categories).flatten!
      end
      @searches = Product.with_keywords(params.dig(:q, :keywords)).ransack(params[:q])
      @products += @searches.result(distinct: true)
      if params[:q][:category_id_in].present?
        @category = Category.find(params[:q][:category_id_in])
        if @category.has_children?
          @products += Product.includes(:images).order("created_at DESC").where(category_id: @category.descendants)
        else
          @category = Category.find(params[:q][:category_id_in])
          @products += Product.includes(:images).order("created_at DESC").where(category_id: @category)
        end
      end

      if params[:q][:sorts] == "id desc"
        @products.sort_by! { |a| a[:id] }.reverse!
      elsif params[:q][:sorts] == "price asc"
        @products.sort_by! { |a| a[:price] }
      elsif params[:q][:sorts] == "price desc"
        @products.sort_by! { |a| a[:price] }.reverse!
      elsif params[:q][:sorts] == "updated_at asc"
        @products.sort_by! { |a| a[:updated_at] }
      elsif params[:q][:sorts] == "updated_at desc"
        @products.sort_by! { |a| a[:updated_at] }.reverse!
      elsif params[:q][:sorts] == "likes_count desc"
        @products.sort_by! { |a| a[:likes_count] }.reverse!
      end

      @checked = "checked" if params[:q][:condition_id_true]
      @checkeds = "checked" if params[:q][:postage_id_true]
    end
    @products.uniq!
  end

  private

  def set_search
    @search = Product.ransack(params[:q])
  end
end
