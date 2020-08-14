Rails.application.routes.draw do
  devise_for :users, controllers: {
                       registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords",
                       omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations",
                     }

  devise_scope :user do
    get "new_user", to: "users/registrations#new_user"
    post "new_user", to: "users/registrations#create_user"
    get "addresses", to: "users/registrations#new_address"
    post "addresses", to: "users/registrations#create_address"
    get "users/profile/:id", to: "users/sessions#show", as: "user_profiles"
    get "show_my_info/:id", to: "users#show_my_info", as: "show_my_info"
    # get "password", to: "users/passwords#new"
  end

  resources :users, path: "/users/mypage", only: [:show, :edit] do
    get "edit_address", to: "addresses#edit", as: "edit_address"
    patch "edit_address", to: "addresses#update"
    put "edit_address", to: "addresses#update"
    collection do
      post :search
    end
    resources :user, only: [:new, :create]
  end

  root "products#index"
  namespace :products do
    resources :searches, only: :index
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
  resources :profiles
end
