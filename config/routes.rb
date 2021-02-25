Rails.application.routes.draw do
  devise_for :users
  
  root 'top#index'
  resources :requests do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users

  

  resources :rooms do
    resources :messages, only: [:index, :create]
  end

  resources :relationships, only: [:create, :destroy]
  
end
