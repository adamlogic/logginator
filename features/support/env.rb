ENV['RACK_ENV'] = 'test'

Bundler.require :default, :cucumber

require File.join(File.dirname(__FILE__), '..', '..', 'logginator.rb')

require 'capybara/cucumber'

Capybara.app                     = Sinatra::Application
Capybara.default_selector        = :css
Capybara.javascript_driver       = :akephalos
Capybara.save_and_open_page_path = 'tmp'

World do
  include RSpec::Expectations
  include RSpec::Matchers
end

# load test data
`mongorestore -d logginator_test -c test_log spec/data/log_entries.bson`

