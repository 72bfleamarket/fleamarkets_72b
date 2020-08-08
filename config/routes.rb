Rails.application.routes.draw do
  devise_for :users, controllers: {
                       registrations: "users/registrations", sessions: "users/sessions",
                       omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations",
                     }
  devise_scope :user do
    get "new_user", to: "users/registrations#new_user"
    post "new_user", to: "users/registrations#create_user"
  end
  devise_scope :user do
    get "addresses", to: "users/registrations#new_address"
    post "addresses", to: "users/registrations#create_address"
  end
  devise_scope :user do
    get "password", to: "users/passwords#new"
    # post 'user', to: 'users//passwords#create'
  end
  devise_scope :user do
    get "users/profile/:id", to: "users/sessions#show", as: "profile"
  end
  resources :users, path: "/users/mypage", only: [:show, :edit]

  root "products#index"
  namespace :products do
    resources :searches, only: :index do
      # collection do
      #   get :search
      # end
    end
  end
  resources :products do
    resources :buyers, only: [:new, :create]
    post "add", to: "likes#create"
    delete "/add", to: "likes#destroy"
    collection do
      get :search
    end
  end
  resources :categories, only: [:index, :show]
  resources :cards, only: [:index, :new, :create, :edit, :show, :destroy]
end
