ENV['RACK_ENV'] = 'test'

Bundler.require :default, :test

require File.join(File.dirname(__FILE__), '..', 'logginator.rb')
