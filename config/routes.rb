Rails.application.routes.draw do
  root "dashboard#index"

  get "/login",           to: "sessions#new"
  post "/login",          to: "sessions#register_authy"
  get "/verify_phone",    to: "sessions#verify_phone"
  post "/verify_phone",   to: "sessions#create"
end
