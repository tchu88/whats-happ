source 'https://rubygems.org'

ruby '2.1.1'

gem 'bootstrap-sass', '~> 3.1.1'
gem 'faraday'
gem 'faraday_middleware', '~> 0.9'
gem 'flutie'
gem 'high_voltage', '~> 2.1'
gem 'jquery-rails'
gem 'pg'
gem 'rails', '4.0.4'
gem 'sass-rails', '~> 4.0.2'
gem 'underscore-rails', '~> 1.6'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'foreman'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'debugger'
  gem 'dotenv-rails'
  gem 'factory_girl_rails', '~> 4.4'
  gem 'ffaker'
end

group :test do
  gem 'database_cleaner', '~> 1.2'
  gem 'rspec-rails', '~> 2.14'
  gem 'shoulda-matchers', '~> 2.5'
  gem 'webmock', '~> 1.17'
end
