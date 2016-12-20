Rails.application.routes.draw do
  get 'uploads/new'

  get 'uploads/create'

  get 'uploads/index'

  post 'uploads/download/:id', to: "uploads#download", as: "download"

  root "dashboard#index"

  get "/login",                           to: "sessions#new"
  post "/login",                          to: "sessions#login"
  post "/create_account",                 to: "sessions#create"
  get "/logout",					                to: "sessions#destroy"
  get "/verify_phone",                    to: "sessions#verify_phone"
  post "/verify_phone",                   to: "sessions#verify_user"
  get "/update_password",                 to: "users#update"
  post "/update_password",                to: "users#update_password"
  get "/update_password_verify_phone",    to: "users#verify_phone"
  post "/update_password_verify_phone",   to: "users#verify_user"

  namespace :admin do
    resources :dashboard, only: [:index, :show]
    resources :users, only: [:edit, :update, :destroy]
  end

  # folders
  get "/public/:folder", to: "folders#public", as: "public"
  get "/private/:folder", to: "folders#private", as: "private"
  resources :folders, only: [:new, :create, :destroy]
  get "/dashboard/:folder", to: "folders#index", as: "current_folder"
  get "/up", to: "folders#up"
  get "/root_folder", to: "folders#root"
  get "/share/:folder", to: "folders#share_form", as: "share"
  post "/share", to: "folders#share"
  get "public_folders", to: "folders#public_folders"


  resources :uploads, only: [:index, :show, :create]

  post "/uploads/destroy", to: "uploads#destroy"

  namespace :upload do
    resources :comments, only: [:new, :create, :show]
  end
end
