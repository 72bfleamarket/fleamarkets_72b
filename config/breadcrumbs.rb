# 共通で表示させたいパンくずリスト
crumb :root do
  link "FURIMA", root_path
end

# 商品関連のパンくずリスト
crumb :categories do
  link "すべてのカテゴリー", categories_path
  parent :root
end

crumb :parent do
  link Category.find(params[:id]).name
  parent :categories
end

crumb :parentParent do
  link Category.find(params[:id]).root.name, category_path(Category.find(params[:id]).root)
  parent :categories
end

crumb :child do
  link Category.find(params[:id]).name
  parent :parentParent
end

crumb :childChild do
  link Category.find(params[:id]).parent.name, category_path(Category.find(params[:id]).parent)
  parent :parentParent
end

crumb :grandchild do
  link Category.find(params[:id]).name
  parent :childChild
end

crumb :category do
  link Category.find(params[:id]).children.name, category_path(Category.find(params[:id]).children)
end

crumb :parents do
  link Product.find(params[:id]).category.root.name, category_path(Product.find(params[:id]).category.root.id)
  parent :categories
end

crumb :children do
  link Product.find(params[:id]).category.parent.name, category_path(Product.find(params[:id]).category.parent.id)
  parent :parents
end

crumb :grandchildren do
  link Product.find(params[:id]).category.name, category_path(Product.find(params[:id]).category.id)
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

crumb :address do
  link "お届け先住所変更"
  parent :mypage
end

crumb :profile do
  link "プロフィール登録・変更"
  parent :mypage
end
# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
