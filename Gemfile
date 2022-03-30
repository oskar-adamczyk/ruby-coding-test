# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "activestorage", "~> 5.2.6.3"
gem "dry-struct"
gem "nokogiri", "~> 1.13.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.6.4"
gem "rails", "~> 5.2.5"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "brakeman"
  gem "bullet"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "database_cleaner"
  gem "factory_bot_rails", ">= 5.0.1"
  gem "faker"
  gem "rspec_junit_formatter"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "shoulda-matchers", "~> 3.1", ">= 3.1.3"
  # Generates a test coverage report on every `bundle exec rspec` call. We use
  # the output to feed SonarCloud's stats and analysis. It does not yet support
  # version >= 0.18 hence locked to 0.17.1
  gem "simplecov", "~> 0.17.1", require: false
  gem "simplecov-json", require: false
end

group :development do
  gem "dotenv-rails", "~> 2.7", ">= 2.7.1", require: false
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
