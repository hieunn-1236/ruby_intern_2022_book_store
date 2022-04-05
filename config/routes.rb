Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_pages#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
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
