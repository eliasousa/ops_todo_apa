source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.1'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false


group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'rubocop-rails', require: false
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 4.0'
end
