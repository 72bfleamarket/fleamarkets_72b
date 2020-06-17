Rails.application.routes.draw do
  get "categories/index"
  root "products#index"
  resources :products
  resources :categories, only: [:index, :show]
end
