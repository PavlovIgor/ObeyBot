source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem 'pg', '0.21.0'
gem 'puma', '~> 3.7'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
gem "figaro", '1.1.1'
# gem 'therubyracer', platforms: :ruby

gem 'devise', '4.3.0'
gem 'activeadmin', '2.0.0', github: 'activeadmin'
gem 'active_admin_flat_skin', '0.1.2'

gem 'jquery-rails', '~> 4.3.1'
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap', '~> 4.0.0.beta3'
gem 'material_icons', '2.2.1'

gem 'uglifier', '>= 1.3.0'
gem 'carrierwave', '~> 0.9'
gem "fog-aws", '~> 1.2'
gem 'whenever', '0.10.0', :require => false
gem "slack-notifier", '2.3.2'
gem 'bcrypt', '3.1.11'

gem 'telegram-bot', '0.13.0'

group :test do
  gem 'rspec-rails', '~> 3.5.2'
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'capybara', '~> 2.13'
  gem 'rubocop', '~> 0.50.0', require: false
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'

end

group :development, :test do
  gem 'byebug', '9.1.0', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'guard-livereload', '~> 2.5',   require: false
  gem 'capistrano', '~> 3.7',         require: false
  gem 'capistrano-rbenv', '2.1.3'
  gem 'capistrano-rails', '~> 1.2',   require: false
  gem 'capistrano-bundler', '~> 1.2', require: false
  gem 'capistrano3-puma', '~> 1.2',   require: false
  gem 'capistrano-sidekiq', '1.0.0'
  gem 'rack-cors', '1.0.2'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'seed_dump', '3.2.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
