source 'http://rubygems.org'

gem 'sinatra', :git => 'http://github.com/sinatra/sinatra.git'
gem 'haml'
gem 'mongo'
gem 'bson_ext', :require => false
gem 'json'

group :development, :test, :cucumber do
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :development do
  gem 'shotgun'
end

group :test, :cucumber do
  gem 'rspec'
end

group :cucumber do
  gem 'cucumber'
  gem 'capybara'
  gem 'launchy'
  gem 'akephalos'
end
