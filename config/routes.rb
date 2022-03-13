# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  get 'sportify_coins_shop', to: 'checkouts#new'
  get 'checkout', to: 'checkouts#show'
  get 'billing', to: 'billing#show'

  devise_for :users
end
