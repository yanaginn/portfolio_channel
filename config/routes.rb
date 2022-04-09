Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users
  resources :portfolios do
    resources :reviews, only: [:index, :create]
  end
end
