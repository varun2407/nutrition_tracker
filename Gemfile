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

# OTHER
gem "jbuilder"
gem "thruster", require: false
gem "bcrypt", "~> 3.1.7"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
# OLLAMA
gem 'ollama-ai', '~> 1.3.0'
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

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