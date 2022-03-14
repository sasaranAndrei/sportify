# frozen_string_literal: true

if !Rails.env.production?
  environment = Rails.env.to_sym
  Stripe.api_key = Rails.application.credentials.dig(environment, :stripe, :private_key)
else
  Stripe.api_key = ENV['STRIPE_API_KEY']
end
