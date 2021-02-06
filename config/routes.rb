Rails.application.routes.draw do
  devise_for :users
  
  root 'top#index'
  resources :requests do
    resources :comments, only: :create
  end
  resources :users
  # root 'messages#index'
  

  resources :rooms do
    resources :messages, only: [:index, :create]
  end

  resources :relationships, only: [:create, :destroy]
  
end
