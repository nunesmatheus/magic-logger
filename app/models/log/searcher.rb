class Log::Searcher
  def self.search(params)
    logs = Log.search({
      query: {
        bool: {
          should: query_terms(params)
        }
      }
    })

    Log::Sorter.sort_by_date(logs)
  end

  def self.query_terms(params)
    params = params.select do |param, value|
      value.present?
    end

    params.map do |param, value|
      { term: { param => value } }
    end
  end
end
