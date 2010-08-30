class LogEntry
  PER_PAGE = 20
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
  
  def self.page(page)
    options = page_opts(page)
    options[:fields] = %w{ request_time controller action }

    COLLECTION.find({}, options)
  end

  def self.find_one(params = {})
    COLLECTION.find_one(params)
  end

  private

    def self.page_opts(page)
      skip = (page - 1) * PER_PAGE
      { :skip => skip, :limit => PER_PAGE }
    end

end
