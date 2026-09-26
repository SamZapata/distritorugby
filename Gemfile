source 'https://rubygems.org/'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server (fijado al rango probado en legacy: 6.x)
gem 'puma', '~> 6.6'
# Stylesheets
gem 'sassc-rails'
# Use Terser as compressor for JavaScript assets
gem 'terser', '~> 1.1'
# JavaScript runtime for ExecJS
gem 'mini_racer', platforms: :ruby
gem 'execjs', '~> 2.8'

# Hotwire Turbo
gem 'turbo-rails'
# Build JSON APIs with ease
gem 'jbuilder', '>= 2.5'
# Templates (fijado al rango probado en legacy: haml-rails 2.x + haml 6.x)
gem 'haml-rails', '~> 2.1'
gem 'haml', '~> 6.3'
# Users management (fijado al rango probado en legacy: devise 4.9.x)
gem 'devise', '~> 4.9.4'
gem 'cancancan', '>= 2.0'
# Bootstrap
gem 'bootstrap', '~> 5.3.1'
# JQuery
gem 'jquery-rails'
# Popper for improve the UI
gem 'popper_js', '>= 2.11.8'
# I18n to internationalize
gem 'rails-i18n', '>= 5.1'
gem 'devise-i18n', '>= 1.6.4'
# Forms
gem 'simple_form', '>= 5.0.0'
# Icons
gem 'font-awesome-rails'
# Slugs
gem 'friendly_id', '>= 5.2.4'
# Uploads media files
gem 'cloudinary'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
end

# Pines de compatibilidad con Rails 7.1 (versiones probadas en legacy):
# json 3.x elimina `quirks_mode` que ActiveSupport::JSON aún pasa.
gem 'json', '~> 2.13'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.4.1'
  gem 'faker'
end

group :test do
  # minitest 6 rompe Rails 7.1 (fijado al rango probado en legacy)
  gem 'minitest', '~> 5.25'
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
