Rails.application.routes.draw do
  devise_for :users
  get "categories/index"
  root "products#index"
  resources :products
  resources :categories, only: [:index, :show]
end
