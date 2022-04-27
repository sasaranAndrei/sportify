# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sportify
  class Application < Rails::Application
    config.load_defaults 6.1

    # Pay configuration
    # maybe has to change to host: 'https://sportify-football.herokuapp.com'
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  end
end
