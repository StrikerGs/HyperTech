Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :products do
    resources :comments, only: %i[create destroy]
    get "myprod", to: "products#myprod"
  end
  resources :profiles, only: %i[new create]
  resources :webhooks, only: [:create]
  get "sucess", to: "checkout#sucess"
  get "cancel", to: "checkout#cancel"
  post "checkout/create", to: "checkout#create"
  get 'main/index'
  get "report", to: "relatorios#report"
  get "reportV", to: "relatorios#reportV"
  get "reportP", to: "relatorios#reportP"
  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "main#index"
end
