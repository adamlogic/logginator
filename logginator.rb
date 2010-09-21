require 'sinatra'
require 'haml'
require 'uri'
require 'mongo'
require 'logger'
require 'lib/log_entry'
require 'lib/helpers'

configure do
  environment     = ENV['RACK_ENV'] || 'development'
  log_file        = "log/#{environment}.log"
  COLLECTION_NAME = "#{environment}_log"

  if mongo_logger_url = (ENV['MONGOHQ_URL'] || ENV['MONGO_LOGGER_URL'])
    uri  = URI.parse(mongo_logger_url)
    conn = Mongo::Connection.from_uri(mongo_logger_url, :logger => Logger.new(log_file))
    DATABASE = conn.db(uri.path.gsub(/^\//, ''))
    DATABASE.authenticate(uri.user, uri.password)
  else
    conn = Mongo::Connection.from_uri('mongodb://localhost', :logger => Logger.new(log_file))
    DATABASE = conn.db("logginator_#{environment}")
  end
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
