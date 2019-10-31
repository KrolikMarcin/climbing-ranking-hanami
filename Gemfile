source 'https://rubygems.org'

gem 'dry-initializer'
gem 'dry-transaction'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rake'
gem 'tachiban'

gem 'pg'

group :development do
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'pry-byebug'
end

group :test do
  gem 'capybara'
  gem 'rspec'
end

group :production do
  # gem 'puma'
end
