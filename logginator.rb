require 'uri'
require 'logger'
require './lib/log_entry'
require './lib/helpers'

set :root, File.dirname(__FILE__)
enable :sessions

use Rack::Auth::Basic do |u, p|
  username = ENV['HTTP_BASIC_USERNAME'] || ENV['USER']
  password = ENV['HTTP_BASIC_PASSWORD'] || ENV['USER']
  u == username && p == password
end

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
  save_params
  @page = (session[:page] || 1).to_i
  @log_entries = LogEntry.page(@page, params[:q])

  if request.xhr?
    content_type :js
    "$('#summaries').html(#{ haml(:summaries).to_json });"
  else
    haml :results
  end
end

def detail
  save_params
  @log_entry = LogEntry.find_one(session[:id])
  @page      = (session[:page] || 1).to_i

  if request.xhr?
    content_type :js
    "$('#detail').html(#{ haml(:detail).to_json });"
  else
    @log_entries = LogEntry.page(@page, params[:q])
    haml :results
  end
end

def save_params
  # session[:q]    = params[:q]    || session[:q]
  session[:id]   = params[:id]   || session[:id]
  session[:page] = params[:page] || session[:page]
end

