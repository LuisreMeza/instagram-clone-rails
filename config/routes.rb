Rails.application.routes.draw do
  get 'users/show'

  root 'posts#index'
  resources :posts
  devise_for :users
  resources :users, only: [:show]
end