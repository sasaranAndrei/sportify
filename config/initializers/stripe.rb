# frozen_string_literal: true

environment = :development || Rails.env.to_sym # ultima parte daca merge si in productie

Stripe.api_key = Rails.application.credentials.dig(environment, :stripe, :private_key)
