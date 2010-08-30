require 'sinatra'
require 'haml'
require 'uri'
require 'mongo'
require 'lib/log_entry'

get '/' do
  @page = 1
  @log_entries = LogEntry.page(@page)
  @log_entry   = LogEntry.find_one
  haml :results
end

get '/page/:page' do |page|
  @page = page.to_i
  @log_entries = LogEntry.page(@page)
  @log_entry   = LogEntry.find_one
  haml :results
end
