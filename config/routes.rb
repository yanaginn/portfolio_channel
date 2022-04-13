Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get "search" => "searches#search"
  resources :users
  resources :portfolios do
    resources :reviews, only: [:index, :create]
  end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
