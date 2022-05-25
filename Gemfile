# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# CORE
gem 'bootsnap', '>= 1.4.4', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.6'
gem 'sprockets-rails', '~> 3.4', '>= 3.4.2'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

# CLOUD
gem 'aws-sdk-s3', require: false

# STYLING
gem 'bootstrap', '~> 5.1.3'
gem 'chartkick', '~> 4.1', '>= 4.1.3'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.8'
gem 'haml', '~> 5.2', '>= 5.2.2'
gem 'haml-rails', '~> 2.0', '>= 2.0.1'
gem 'sass-rails', '>= 6'

# AUTHENTICATION
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'activeadmin', '~> 2.13', '>= 2.13.1'

# PAYMENT
gem 'pay', '~> 3.0'
gem 'stripe', '>= 2.8', '< 6.0'
gem 'braintree', '>= 4.4', '< 5.0'
gem 'paddle_pay', '~> 0.1'
gem 'receipts', '~> 1.1'

# OTHER
gem 'active_record_union'
gem 'date_validator', '~> 0.12.0'
gem 'groupdate'

# add?: rspec, redis, faker, chartkick, dotenv

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop', '~> 1.25', '>= 1.25.1'
end

group :development do
  gem 'bullet', '~> 7.0', '>= 7.0.1'
  gem 'letter_opener', '~> 1.7'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
