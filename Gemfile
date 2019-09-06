ruby '2.6.3'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 6.0.0'
gem 'puma', '~> 4.1.0'
gem 'sass-rails', '~> 6.0.0'
gem 'uglifier', '~> 4.1.20'
gem 'coffee-rails', '~> 5.0.0'
gem 'jquery-rails', '~> 4.3.5'
gem 'turbolinks', '~> 5.2.0'
gem 'webpacker', '~> 4.0.7'
gem 'sdoc', '~> 1.0.0', group: :doc

gem 'pg', '~> 1.1.4'
gem 'devise', '~> 4.7.0'
gem 'simple_form', '~> 4.1.0'
gem 'materialize-sass', '~> 1.0.0'
gem 'rails-i18n', '~> 6.0.0'
gem 'math_engine', '~> 0.7.0'

gem 'font-awesome-rails', '~> 4.7'
gem 'mini_magick', '~> 4.9.5'
gem 'ckeditor', '~> 5.0.0'
gem 'breadcrumbs_on_rails', '~> 3.0.1'
gem 'active_link_to', '~> 1.0.5'
gem 'handlebars_assets', '~> 0.23.4'
gem 'jquery-hotkeys-rails', '~> 0.7.9'
gem 'codemirror-rails', '~> 0.3.1'
gem 'active_model_serializers', '~> 0.10.10'

group :development do
  gem 'populator'
  gem 'web-console'
  gem 'byebug'
  gem 'guard-rails', require: false
  gem 'guard-rspec', require: false

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'spring'
  gem 'faker'
  gem 'better_errors'
  gem 'factory_bot_rails'
  gem 'simplecov'
  gem 'rspec-rails'
  gem 'capybara'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'json-schema'
end

group :production do
end
