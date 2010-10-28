ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'logginator.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'akephalos'

Capybara.app                     = Sinatra::Application
Capybara.default_selector        = :css
Capybara.default_driver          = :akephalos
Capybara.save_and_open_page_path = 'tmp'

World do
  include RSpec::Expectations
  include RSpec::Matchers
end

# load test data
`mongorestore -d logginator_test -c test_log spec/data/log_entries.bson`

