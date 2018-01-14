class Log::Parser
  attr_accessor :raw_log

  def initialize(raw_log='')
    @raw_log = raw_log

    attribute_names.each do |name|
      define_singleton_method(name) do
        attribute(name)
      end
    end
  end

  def timestamp
    raw_date = @raw_log.scan(/\S+/)[2]
    date = Time.try(:parse, raw_date)
    return Time.current if raw_date.blank?
    date.in_time_zone('Brasilia')
  end


  private

  def attribute(attribute)
    raw_attribute = raw_attributes.find { |x| x.starts_with?("#{attribute}=") }
    raw_attribute.sub("#{attribute}=", '').gsub('"', '')
  end

  def raw_attributes
    @raw_log.scan(/\S+=\S+/)
  end

  def attribute_names
    @raw_log.scan(/(\S+)=/).flatten
  end
end
