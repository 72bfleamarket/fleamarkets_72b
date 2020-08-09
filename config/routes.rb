Rails.application.routes.draw do
  devise_for :users, controllers: {
                       registrations: "users/registrations", sessions: "users/sessions",
                       omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations",
                     }

  devise_scope :user do
    get "new_user", to: "users/registrations#new_user"
    post "new_user", to: "users/registrations#create_user"
    get "addresses", to: "users/registrations#new_address"
    post "addresses", to: "users/registrations#create_address"
    get "users/profile/:id", to: "users/sessions#show", as: "profile"
    get "edit_address/:id", to: "users#edit_address", as: "edit_address"
    patch "edit_address/:id", to: "users#update_address"
    put "edit_address/:id", to: "users#update_address"
    get "password", to: "users/passwords#new"
  end

  resources :users, path: "/users/mypage", only: [:show, :edit, :update]

  root "products#index"
  namespace :products do
    resources :searches, only: :index do
    end
  end
  resources :products do
    resources :buyers, only: [:new, :create]
    resources :comments, only: [:create, :destroy]
    post "add", to: "likes#create"
    delete "/add", to: "likes#destroy"
    collection do
      get :search
    end
  end
  resources :categories, only: [:index, :show]
  resources :cards, only: [:index, :new, :create, :edit, :show, :destroy]
end
