Rails.application.routes.draw do
  devise_for :users,
             controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  scope "(:locale)", locale: /en|vi/ do
    root "home_pages#index"
    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
      get "/signup", to: "devise/registration#new"
    end
    delete "/carts", to: "carts#destroy"
    put "/carts", to: "carts#update_quantity"
    resources :home_pages, only: %i(index show)
    namespace :admin do
      root "books#index"
      resources :books do
        member do
          get :restore
        end
      end
      resources :charts, only: :index
      resources :orders, only: %i(index update show)
    end
    resources :home_pages, only: :index
    resources :books
    resources :orders
    resources :carts, only: %i(index create)
  end
end
