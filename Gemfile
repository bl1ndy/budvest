# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'cssbundling-rails'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails', '~> 4.5'
gem 'jsbundling-rails'
gem 'pg', '~> 1.4', '>= 1.4.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0', '>= 7.0.4.2'
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'
gem 'slim-rails', '~> 3.5', '>= 3.5.1'
gem 'sprockets-rails'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 5.1.2'
end

group :development do
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'
  gem 'listen', '~> 3.3'
  gem 'overcommit', '~> 0.60.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', '~> 1.30', '>= 1.30.1', require: false
  gem 'rubocop-performance', '~> 1.14', '>= 1.14.2', require: false
  gem 'rubocop-rails', '~> 2.14', '>= 2.14.2', require: false
  gem 'rubocop-rspec', '~> 2.12', '>= 2.12.1', require: false
  gem 'slim_lint', '~> 0.24.0'
  gem 'solargraph', '~> 0.48.0'
  gem 'solargraph-rails', '~> 1.1'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '~> 3.38'
  gem 'capybara-email', '~> 3.0', '>= 3.0.2'
  gem 'launchy', '~> 2.5'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'selenium-webdriver', '~> 4.8', '>= 4.8.1'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'simplecov', '~> 0.22.0', require: false
  gem 'webdrivers'
end
