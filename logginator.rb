require 'sinatra'
require 'haml'
require 'uri'
require 'mongo'
require 'json'
require 'logger'
require 'lib/log_entry'
require 'lib/helpers'

configure do
  environment     = ENV['RACK_ENV'] || 'development'
  log_file        = "log/#{environment}.log"
  COLLECTION_NAME = ENV['LOGGINATOR_COLLECTION'] || "#{environment}_log"

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

  haml :results
end

get '/search' do
  @page = params[:page] || 1
  @log_entries = LogEntry.page(@page, params['q'])

  content_type :js
  "$('#summaries').html(#{ haml(:summaries).to_json });"
end

get '/entry/:id' do |id|
  @log_entry   = LogEntry.find_one(id)

  content_type :js
  "$('#detail').html(#{ haml(:detail).to_json });"
end
