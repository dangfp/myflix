source 'https://rubygems.org'
ruby '2.1.1'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'bcrypt-ruby', '~> 3.1.5'
gem 'jquery-rails'
gem 'pg'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
end

group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'shoulda-matchers', require: false
  gem 'fabrication', '~> 2.12.1'
  gem 'faker', '~> 1.4.3'
  gem 'capybara'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end
