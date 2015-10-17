source 'https://rubygems.org'

ruby '2.2.3'

gem 'active_model_serializers'
gem 'apipie-rails',                     '0.3.3' # https://github.com/Apipie/apipie-rails/issues/353
gem 'dalli'
gem 'rails', '4.2.4'

# HTML, JS, CSS
gem 'angularjs-rails-resource'
gem 'angularjs-rails'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'font-awesome-sass'
gem 'jquery-rails'
gem 'sass-rails'
gem 'simple_form'
gem 'slim-rails'
gem 'uglifier'

source 'https://rails-assets.org' do
  gem 'rails-assets-angular-bootstrap'
  # gem 'rails-assets-angularjs-rails-resource'
end

group :production do
  gem 'connection_pool'
  gem 'puma'
  gem 'rack-timeout'
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'web-console'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'thin'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end
