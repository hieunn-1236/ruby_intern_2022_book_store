Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_pages#index"
    get "/product", to: "pages#product"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :home_pages, only: %i(index show)
    namespace :admin do
      root "books#index"
      resources :books
    end
    resources :home_pages, only: :index
    resources :books
    resources :orders
    resources :carts, only: :create
  end
end
