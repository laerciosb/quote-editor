# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'
# Use Dart SASS [https://github.com/rails/dartsass-rails]
gem 'dartsass-rails'
# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'
# Ruby wrapper for hiredis
gem 'hiredis'
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

################################################################################
# Monitoring
################################################################################

# The Ruby OpenTelemetry client.
gem 'opentelemetry-exporter-otlp'
gem 'opentelemetry-instrumentation-active_job'
gem 'opentelemetry-instrumentation-concurrent_ruby'
gem 'opentelemetry-instrumentation-net_http'
gem 'opentelemetry-instrumentation-pg'
gem 'opentelemetry-instrumentation-rails'
gem 'opentelemetry-sdk'

################################################################################
# For App Support
################################################################################

# An attempt to tame Rails' default policy to log everything.
gem 'lograge'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw]

  # Ruby library that pretty prints Ruby objects in full color exposing
  gem 'amazing_print'
  # help to kill N+1 queries and unused eager loading
  gem 'bullet'
  # Use Factory Bot to create objects dynamically
  gem 'factory_bot_rails'
  # Use RSpec to execute specs suite
  gem 'rspec-rails'
  # Shim to load environment variables from .env into ENV in development.
  gem 'dotenv-rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'

  # Add a comment summarizing the current schema to the top or bottom of each of your
  gem 'annotate'
  # RuboCop is a Ruby static code analyzer
  gem 'rubocop', require: false
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails', require: false
  # Code style checking for RSpec files
  gem 'rubocop-rspec', require: false
  # An extension of RuboCop focused on code performance checks.
  gem 'rubocop-performance', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'

  # Use for test coverage
  gem 'simplecov', require: false
  # Collection of testing matchers
  gem 'shoulda-matchers'
end
