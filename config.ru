require 'rubygems'
require 'bundler'

Bundler.require

require 'uri'
require 'logger'
require './lib/log_entry'
require './lib/helpers'
require './logginator'

run Sinatra::Application
