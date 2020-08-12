json.array! @childrens do |child|
  json.id child.id
  json.name child.name
end
json.array! @grandChilds do |gc|
  json.id gc.id
  json.name gc.name
  json.root gc.root_id
end
json.array! @parents do |parent|
  json.parent parent.parent_id
end
json.array! @allProducts do |product|
  json.id product.id
  json.name product.name
  json.brand product.brand
end
json.array! @allCategorys do |category|
  json.id category.id
  json.name category.name
end
json.array! @user do |user|
  json.id user.id
  json.name user.name
end
