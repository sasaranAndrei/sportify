# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  
  # BUSINESS LOGIC
  resources :sports
  resources :arenas
  resources :fields
  resources :reservations do
    get :join_requests, on: :member
  end
  
  resources :join_requests do
    put :approve, on: :member
    put :decline, on: :member
  end

  resources :players do
    get :stats, on: :member
    get :reservations, on: :member
    get :join_requests, on: :member
  end
  
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
