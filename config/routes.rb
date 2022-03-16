Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_pages#index"
    get "/products", to: "pages#products"
    get "/admin", to: "pages#admin"
    get "/product", to: "pages#product"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/login", to: "pages#login"
    resources :home_pages, only: %i(index show)
  end
end
