source "https://rubygems.org"

gem "rails", "~> 8.0.2"

#DRIVERS
gem "mysql2", "~> 0.5"

# DEPLOYMENT
gem "puma", ">= 5.0"

# FRONTEND
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "rails_charts", "~> 0.0.6"

# OTHER
gem "jbuilder"
gem "thruster", require: false
gem "bcrypt", "~> 3.1.7"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "aasm"

# OLLAMA
gem 'ollama-ai', '~> 1.3.0'

gem "bootsnap", require: false
gem "kamal", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end