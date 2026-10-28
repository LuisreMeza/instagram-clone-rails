Rails.application.routes.draw do
  root 'posts#index'
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  
  devise_for :users
  resources :users, only: [:show]
end