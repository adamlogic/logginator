require 'sinatra'
require 'haml'
require 'uri'
require 'mongo'
require 'chronic'
require 'lib/log_entry'
require 'lib/helpers'

get '/' do
  @page = 1
  params['q'] ||= {}
  @from = params['q']['from'] = Chronic.parse(params['q']['from']) || Chronic.parse('1/1/10')
  @to   = params['q']['to']   = Chronic.parse(params['q']['to']) || Time.now
  @log_entries = LogEntry.page(@page, params['q'])
  @log_entry   = LogEntry.find_one(@log_entries.first)
  haml :results
end

get '/page/:page' do |page|
  @page = page.to_i
  params['q'] ||= {}
  @from = params['q']['from'] = Chronic.parse(params['q']['from']) || Chronic.parse('1/1/10')
  @to   = params['q']['to']   = Chronic.parse(params['q']['to']) || Time.now
  @log_entries = LogEntry.page(@page, params['q'])
  @log_entry   = LogEntry.find_one(@log_entries.first)
  haml :results
end

get '/page/:page/entry/:id' do |page, id|
  @page = page.to_i
  params['q'] ||= {}
  @from = params['q']['from'] = Chronic.parse(params['q']['from']) || Chronic.parse('1/1/10')
  @to   = params['q']['to']   = Chronic.parse(params['q']['to']) || Time.now
  @log_entries = LogEntry.page(@page, params['q'])
  @log_entry   = LogEntry.find_one(id)
  haml :results
end
