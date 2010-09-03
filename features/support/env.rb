ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'logginator.rb')

require 'capybara'
require 'capybara/cucumber'
require 'spec'

Capybara.app = Sinatra::Application

World do
  include Capybara
  include Spec::Expectations
  include Spec::Matchers
end

# load test data
`mongorestore -d logginator_test -c log_entries spec/data/log_entries.bson`

