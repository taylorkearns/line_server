Rails.application.routes.draw do
  root "home#show"

  namespace :api do
    resources :lines, only: [:show]
  end
end
