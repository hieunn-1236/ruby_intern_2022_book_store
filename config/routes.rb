Rails.application.routes.draw do
  devise_for :users
  scope "(:locale)", locale: /en|vi/ do
    root "home_pages#index"
    as :user do
      get "/login", to: "devise/session#new"
      post "/login", to: "devise/session#create"
      delete "/logout", to: "devise/session#destroy"
      get "/signup", to: "devise/registration#new"
    end
    delete "/carts", to: "carts#destroy"
    put "/carts", to: "carts#update_quantity"
    resources :home_pages, only: %i(index show)
    namespace :admin do
      root "books#index"
      resources :books
      resources :orders, only: %i(index update show)
    end
    resources :home_pages, only: :index
    resources :books
    resources :orders
    resources :carts, only: %i(index create)
  end
end
