Rails.application.routes.draw do
  get 'purchases/index'
  get 'purchases/done'
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

  root "products#index"
  resources :products, only: [:index, :new, :create, :show] do
    resources :categories, only:[:create]
  end
  resources :products
  resources :categories, only: [:index, :show]

  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end
end
