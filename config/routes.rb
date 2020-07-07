Rails.application.routes.draw do
  root "tops#home"
  get "features", to: "tops#about"
  get "help",     to: "tops#help"
  get "contact",  to: "tops#contact"

  resources :orders
  resources :medicines, only: [:show, :index]

end
