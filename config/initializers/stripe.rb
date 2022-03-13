# frozen_string_literal: true

environment = Rails.env.to_sym
Stripe.api_key = Rails.application.credentials.dig(environment, :stripe, :private_key)
