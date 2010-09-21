class LogEntry
  PER_PAGE = 25

  def self.collection
    @collection ||= DATABASE.collection(COLLECTION_NAME)
  end

  def self.page(page, params = {})
    params ||= {}
    options = page_opts(page)
    options[:fields] = %w{ request_time controller action }
    options[:sort] = ['$natural', :desc]

    collection.find(clean_params(params), options).to_a
  end

  def self.find_one(id_or_doc, params = {})
    params ||= {}
    object_id = case id_or_doc
      when BSON::OrderedHash then id_or_doc['_id']
      when String then BSON.ObjectId(id_or_doc)
      else id_or_doc
    end

    collection.find_one(object_id, clean_params(params))
  end

  private

    def self.page_opts(page)
      skip = (page - 1) * PER_PAGE
      { :skip => skip, :limit => PER_PAGE }
    end

    def self.clean_params(params)
      params = params.reject { |k,v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }

      if (from = params.delete('from')) && !from.empty?
        from = Time.parse(from)
        params['request_time'] ||= {}
        params['request_time'][:$gt] = from + from.utc_offset
      end

      if (to = params.delete('to')) && !to.empty?
        to = Time.parse(to)
        params['request_time'] ||= {}
        params['request_time'][:$lt] = to + to.utc_offset
      end

      params.delete('param')
      params
    end

end
