Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :users
    get "/products", to: "pages#products"
  end
end
