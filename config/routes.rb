# frozen_string_literal: true

Rails.application.routes.draw do
  resources :reservations
  root 'pages#home'
  
  # BUSINESS LOGIC
  resources :sports
  resources :arenas
  resources :fields
    
  # PAY
  get 'sportify_coins_shop', to: 'checkouts#new'
  get 'checkout', to: 'checkouts#show'
  
  resource :checkout do
    get 'success'
    get 'cancel'
  end

  # USER
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }
end
