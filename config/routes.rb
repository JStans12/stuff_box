Rails.application.routes.draw do
  root "dashboard#index"

  get "/login", to: "sessions#new"
  post "/create_account", to: "sessions#register_authy"
end
