# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'rails', '~> 5.0.7.2'
gem 'rails-i18n', '~> 5.0.0'

gem 'puma', '~> 3.0'

gem 'pg'

gem 'devise-i18n'
gem 'devise_token_auth'

gem 'active_model_serializers', '~> 0.10.0'
gem 'kaminari'
gem 'rack-cors'
gem 'versionist'

group :development, :test do
  gem 'awesome_print'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'rails-erd'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
