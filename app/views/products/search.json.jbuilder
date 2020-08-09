json.array! @childrens do |child|
  json.id child.id
  json.name child.name
end
json.array! @grandChilds do |gc|
  json.id gc.id
  json.name gc.name
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
