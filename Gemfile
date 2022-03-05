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

# STYLING
gem 'bootstrap', '~> 5.1.3'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.8'
gem 'haml', '~> 5.2', '>= 5.2.2'
gem 'sass-rails', '>= 6'

# add: chartkick, font-awsome-rails, rubocop, dotenv, bullet, letter_opener
# add?: redis, faker,

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
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
