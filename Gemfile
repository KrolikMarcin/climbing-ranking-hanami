source 'https://rubygems.org'

gem 'bcrypt'
gem 'dry-initializer'
gem 'dry-transaction'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'pg'
gem 'rake'

group :development do
  gem 'hanami-webconsole'
  # TODO: fix shotgun issue
  # gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'factory_bot'
  gem 'faker'
  gem 'pry-byebug'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec-hanami'
end

group :production do
  # gem 'puma'
end
