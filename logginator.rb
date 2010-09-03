require 'sinatra'
require 'haml'
require 'uri'
require 'mongo'
require 'chronic'
require 'lib/log_entry'
require 'lib/helpers'

configure :development do
  conn = Mongo::Connection.from_uri('mongodb://localhost')
  DATABASE = conn.db('logginator_dev')
end

configure :test do
  conn = Mongo::Connection.from_uri('mongodb://localhost')
  DATABASE = conn.db('logginator_test')
end

configure :production do
  uri  = URI.parse(ENV['MONGOHQ_URL'])
  conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  DATABASE = conn.db(uri.path.gsub(/^\//, ''))
end

get '/' do
  @page = 1
  @log_entries = LogEntry.page(@page, params['q'])
  @log_entry   = LogEntry.find_one(@log_entries.first)
  haml :results
end

get '/page/:page' do |page|
  @page = page.to_i
  @log_entries = LogEntry.page(@page, params['q'])
  @log_entry   = LogEntry.find_one(@log_entries.first)
  haml :results
end

get '/page/:page/entry/:id' do |page, id|
  @page = page.to_i
  @log_entries = LogEntry.page(@page, params['q'])
  @log_entry   = LogEntry.find_one(id)
  haml :results
end
