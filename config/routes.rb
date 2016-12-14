Rails.application.routes.draw do
  root "dashboard#index"

  get "/login",           to: "sessions#new"
  post "/login",          to: "sessions#create"
  get "/logout",					to: "sessions#destroy"
  get "/verify_phone",    to: "sessions#verify_phone"
  post "/verify_phone",   to: "sessions#verify_user"
end
