# frozen_string_literal: true

Rails.application.routes.draw do
  root 'reservations#index'
  get '/gamesfeed', to: 'reservations#index'

  # BUSINESS LOGIC
  resources :sports
  resources :arenas, only: %i[ update index show ]
  resources :fields
  resources :reservations do
    get :join_requests, on: :member
    get :generate_invitation_link, on: :member
    get :accept_invitation, on: :member
    get :timetable, on: :collection # daca merge move to field#timetable
  end
  
  resources :reservation_players
  resources :player_reviews

  resources :join_requests do
    put :approve, on: :member
    put :decline, on: :member
  end

  resources :players do
    get :stats, on: :member
    get :reservations, on: :member
    get :collection, on: :member
    get :join_requests, on: :member
  end

  # SHOP
  resources :balls
  resources :tshirts
  
  # PAY
  get 'sportify_coins_shop', to: 'checkouts#new'
  get 'checkout', to: 'checkouts#show'
  
  resource :checkout do
    get 'success'
    get 'cancel'
  end

  # USER
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  resource :sportify_admin, only: :show do
    get 'test_mailer'
  end
  get '/admin', to: 'sportify_admins#show'
  get '/dashboard', to: 'sportify_admins#show'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }
end
