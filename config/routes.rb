Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home_page#index"

  get "home_page/index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "register", to: "users#new"

  resources :bids, only: %i[index]

  resources :users, except: %i[new] do
    resources :bids, only: %i[index]
  end
  resources :products do
    resources :bids, only: %i[new create edit update]
  end
end
