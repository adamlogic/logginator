class LogEntry
  PER_PAGE = 25
  COLLECTION = begin
    if ENV['MONGOHQ_URL']
      uri  = URI.parse(ENV['MONGOHQ_URL'])
      conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
      db   = conn.db(uri.path.gsub(/^\//, ''))
      db.collection('staging_log')
    else
      conn = Mongo::Connection.from_uri('mongodb://localhost')
      db   = conn.db('janova_staging')
      db.collection('staging_log')
    end
  end
  
  def self.page(page, params = {})
    options = page_opts(page)
    options[:fields] = %w{ request_time controller action }

    COLLECTION.find(clean_params(params), options)
  end

  def self.find_one(id, params = {})
    COLLECTION.find_one(id, clean_params(params))
  end

  def self.first_on_page(page, params = {})
    COLLECTION.find_one(clean_params(params), page_opts(page))
  end

  private

    def self.page_opts(page)
      skip = (page - 1) * PER_PAGE
      { :skip => skip, :limit => PER_PAGE }
    end

    def self.clean_params(params)
      params = params.reject { |k,v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }

      if params['from']
        params['request_time'] ||= {}
        params['request_time'][:$gt] = params.delete('from')
      end

      if params['to']
        params['request_time'] ||= {}
        params['request_time'][:$lt] = params.delete('to')
      end

      params.delete('param')
      params
    end

end
