source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'rails', '~> 5.1.3'
gem 'active_model_serializers'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem "devise"
gem 'coffee-rails', '~> 4.2'
gem 'compass-rails', github: 'Compass/compass-rails'
gem 'furatto', git: 'git@github.com:IcaliaLabs/furatto-rails.git'
gem 'font-awesome-rails'
gem 'simple_form'

group :test do
   gem "rspec-rails"
   gem "factory_girl_rails"
   gem 'ffaker'
   gem "shoulda-matchers"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'binding_of_caller'
  gem 'pry'
  gem 'better_errors'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sqlite3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
