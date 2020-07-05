Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  devise_scope :user do
    get  'user', to: 'users/registrations#new_user'
    post 'user', to: 'users/registrations#create_user'
  end
  devise_scope :user do
    get  'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  devise_scope :user do
    get  'password', to: 'users/passwords#new'
    # post 'user', to: 'users//passwords#create'
  end
  resources :users, only: :show

  root "products#index"
  resources :products do
    resources :categories, only:[:create]
    resources :buyers, only: [:new, :create]
  end
  resources :categories, only: [:index, :show]

  resources :cards, only: [:new, :create, :show, :destroy]
end
