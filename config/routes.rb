Rails.application.routes.draw do
  root to: 'products#index'

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
  resources :products, only: [:index, :new, :create, :show] do
    resources :categories, only:[:create]
  end
end
