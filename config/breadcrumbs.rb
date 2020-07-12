# 共通で表示させたいパンくずリスト
crumb :root do
  link "FURIMA", root_path
end

# 商品関連のパンくずリスト
crumb :categories do
  link "すべてのカテゴリー", categories_path
  parent :root
end

crumb :parents do
  link Product.find(params[:id]).category.root.name, categories_path(Product.find(params[:id]).category.root.id)
  parent :categories
end

crumb :children do
  link Product.find(params[:id]).category.parent.name, categories_path(Product.find(params[:id]).category.parent.id)
  parent :parents
end

crumb :grandchildren do
  link Product.find(params[:id]).category.name, categories_path(Product.find(params[:id]).category.id)
  parent :children
end

crumb :product do
  link Product.find(params[:id]).name
  parent :grandchildren
end

#ユーザーマイページのパンくずリスト
crumb :mypage do
  link "マイページ", user_path(current_user.id)
  parent :root
end

crumb :payment do
  link "支払い方法", new_card_path
  parent :mypage
end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
