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

