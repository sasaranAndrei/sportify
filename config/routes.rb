# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  get 'checkout', to: 'checkouts#show'
  get 'billing', to: 'billing#show'

  devise_for :users
end
