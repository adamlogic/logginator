ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'logginator.rb')

require 'capybara'
require 'capybara/cucumber'
require 'spec'

Capybara.app = Sinatra::Application

Capybara.default_selector = :css

World do
  include Capybara
  include Spec::Expectations
  include Spec::Matchers
end

# load test data
`mongorestore -d logginator_test -c test_log spec/data/log_entries.bson`

