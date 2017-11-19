class Log::Searcher
  def self.search(params)
    query = query_from_params params
    Log.search query_from_params(params)
  end

  def self.query_from_params(params)
    params = params.select do |param, value|
      value.present?
    end

    params.map do |param, value|
      "#{param}:#{value}"
    end.join(" ")
  end
end
