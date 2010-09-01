class LogEntry
  PER_PAGE = 25
  COLLECTION = begin
    if ENV['MONGOHQ_URL']
      uri  = URI.parse(ENV['MONGOHQ_URL'])
      conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
      db   = conn.db(uri.path.gsub(/^\//, ''))
      db.collection('production_log')
    else
      conn = Mongo::Connection.from_uri('mongodb://localhost')
      db   = conn.db('janova_staging')
      db.collection('staging_log')
    end
  end
  
  def self.page(page, params = {})
    options = page_opts(page)
    options[:fields] = %w{ request_time controller action }

    COLLECTION.find(clean_params(params), options).to_a
  end

  def self.find_one(id_or_doc, params = {})
    object_id = case id_or_doc
      when BSON::OrderedHash then id_or_doc['_id']
      when String then BSON.ObjectId(id_or_doc)
      else id_or_doc
    end

    COLLECTION.find_one(object_id, clean_params(params))
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
