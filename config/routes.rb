Rails.application.routes.draw do
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  get "/profile", to: "profile#show"
  resources :tasks
end
