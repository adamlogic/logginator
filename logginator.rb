require 'uri'
require 'logger'
require './lib/log_entry'
require './lib/helpers'

set :root, File.dirname(__FILE__)

configure do
  environment     = ENV['RACK_ENV'] || 'development'
  log_file        = "log/#{environment}.log"
  COLLECTION_NAME = ENV['LOGGINATOR_COLLECTION'] || "#{environment}_log"

  if mongo_logger_url = ENV['MONGOHQ_URL']
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
  search
end

get '/search' do
  search
end

get '/entry/:id' do
  detail
end

def search
  @page = (params[:page] || 1).to_i
  @log_entries = LogEntry.page(@page, params[:q])

  if request.xhr?
    content_type :js
    "$('#summaries').html(#{ haml(:summaries).to_json });"
  else
    haml :results
  end
end

def detail
  @log_entry = LogEntry.find_one(params[:id])
  @page      = (params[:page] || 1).to_i

  if request.xhr?
    content_type :js
    "$('#detail').html(#{ haml(:detail).to_json });"
  else
    @log_entries = LogEntry.page(@page, params[:q])
    haml :results
  end
end
