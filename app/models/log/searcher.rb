class Log::Searcher
  def self.search(params, options={})
    return Log.all unless params.any? || options[:before_log].present?

    logs = Log.search({
      from: 0, size: 10000,
      query: {
        bool: {
          should:
            query_terms(params) +
            before_log(options[:before_log])
          }
        }
    })

    Log::Sorter.sort_by_date(logs)
  end

  def self.before_log(log)
    return [] if log.blank?

    [
      {
        range: {
          timestamp: {
            lte: log.timestamp,
          }
        }
      }
    ]
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
