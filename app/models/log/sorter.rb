class Log::Sorter
  def self.sort_by_date(logs)
    logs.sort do |x,y|
      x.timestamp.to_f <=> y.timestamp.to_f
    end.reverse
  end
end
