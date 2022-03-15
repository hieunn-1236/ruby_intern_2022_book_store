Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :users
    get "/products", to: "pages#products"
    get "/admin", to: "pages#admin"
    get "/login", to: "pages#login"
  end
end
