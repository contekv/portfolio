Rails.application.routes.draw do

  root "tops#top"
  get "features", to: "tops#about"
  get "help",     to: "tops#help"
  get "contact",  to: "tops#contact"
  resources :homes
  resources :messages
  resources :conversations
  resources :admins
  resources :orders
  resources :medicines do
    get :record, on: :member
  end
  resources :users do
    get :purge, on: :member
  end
  namespace :users, only: :index do
    resources :users, only: :show do
      resources :orders, only: :index
    end
  end

  # ログイン、アカウント編集後、任意のページに推移させるための記述
  devise_for :users, skip: :all, controllers: {
    sessions: "users/sessions",
    registraions: "users/registraiotns",
    passwords: "users/passwords" }

  devise_scope :user do
    get "login", to: "devise/sessions#new", as: :new_user_session
    post "login", to: "devise/sessions#create", as: :user_session
    delete "logout", to: "devise/sessions#destroy", as: :destroy_user_session
    get "signup", to: "devise/registrations#new", as: :new_user_registration
    post "signup/create", to: "devise/registrations#create", as: :user_registration
    get "signup/cancel", to: "devise/registrations#cancel", as: :cancel_user_registration
    get "user", to: "devise/registrations#edit", as: :edit_user_registration
    patch "user", to: "devise/registrations#update", as: nil
    put "/signup/create", to: "users/registrations#update", as: :update_user_registration
    delete "/signup/create", to: "users/registrations#destroy", as: :destroy_user_registration
    get "password", to: "devise/passwords#new", as: :new_user_password
    post "password", to: "devise/passwords#create", as: :user_password
    get "password/edit", to: "devise/passwords#edit", as: :edit_user_password
    patch "password", to: "devise/passwords#update"
    put "password", to: "devise/passwords#update", as: :update_user_password
    post "users/guest_sign_in", to: "users/sessions#test_guest"
  end
end