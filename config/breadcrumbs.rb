crumb :root do
  link "FURIMA", root_path
end

crumb :categories do
  link "すべてのカテゴリー", "#"
  parent :root
end

crumb :parents do
  link Product.find(params[:id]).category.root.name, "#"
  parent :categories
end

crumb :children do
  link Product.find(params[:id]).category.parent.name, "#"
  parent :parents
end

crumb :grandchildren do
  link Product.find(params[:id]).category.name, "#"
  parent :children
end

crumb :product do
  link Product.find(params[:id]).name
  parent :grandchildren
end
# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).