Rails.application.routes.draw do
  root "products#index"
  namespace :products do
    resources :searches, only: :index
  end
  resources :products, only: [:index, :new, :create, :show]
  resources :categories, only: [:index]
end
