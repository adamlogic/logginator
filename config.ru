require 'rubygems'
require 'bundler'

Bundler.require

require './logginator'

run Sinatra::Application
