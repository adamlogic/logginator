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
      db   = conn.db('logginator_dev')
      db.collection('log_entries')
    end
  end
  
  def self.page(page, params = {})
    params ||= {}
    options = page_opts(page)
    options[:fields] = %w{ request_time controller action }

    COLLECTION.find(clean_params(params), options).to_a
  end

  def self.find_one(id_or_doc, params = {})
    params ||= {}
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

      if from = Chronic.parse(params.delete('from'))
        params['request_time'] ||= {}
        params['request_time'][:$gt] = from.utc
      end

      if to = Chronic.parse(params.delete('to'))
        params['request_time'] ||= {}
        params['request_time'][:$lt] = to.utc
      end

      params.delete('param')
      params
    end

end
