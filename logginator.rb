require 'sinatra'
require 'haml'
require 'uri'
require 'mongo'
require 'lib/log_entry'
require 'lib/helpers'

get '/' do
  @page = 1
  @log_entries = LogEntry.page(@page)
  @log_entry   = LogEntry.first_on_page(@page)
  haml :results
end

get '/page/:page' do |page|
  @page = page.to_i
  @log_entries = LogEntry.page(@page)
  @log_entry   = LogEntry.first_on_page(@page)
  haml :results
end

get '/page/:page/entry/:id' do |page, id|
  @page = page.to_i
  @log_entries = LogEntry.page(@page)
  @log_entry   = LogEntry.find_one(BSON.ObjectId(id))
  haml :results
end
