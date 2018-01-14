class Log
  require 'elasticsearch/persistence/model'
  include Elasticsearch::Persistence::Model

  index_name "log_#{Rails.env}"

  attribute :http_method, String
  attribute :request_id, String
  attribute :status, String
  attribute :host, String
  attribute :path, String, mapping: { analyzer: 'special_characters' }
  attribute :fwd, String
  attribute :raw, String
  attribute :timestamp, DateTime

  before_save :capitalize_http_method

  def to_s
    if has_expected_format?
      time = DateTime.parse raw
      beautiful_time = time.strftime("%d/%m/%Y - %H:%M:%S %L")
      ugly_date = time.strftime("%Y-%m-%dT%H:%M:%S.%6N%Z")
      return "#{beautiful_time} #{raw.sub(ugly_date, '')}"
    end

    self.class.ordered_attributes.map(&:to_sym).map do |attribute|
      value = self.send(attribute).to_s
      if attribute == :created_at
        value = created_at.strftime("%d/%m/%Y - %H:%M:%S %L")
      end

      "#{attribute}=#{value}"
    end.join(" ")
  end

  def self.ordered_attributes
    %w(created_at http_method host path status fwd request_id)
  end

  def self.attributes
    self.attribute_set.entries.map(&:name)
  end

  def self.relevant_attributes
    self.attributes - [:created_at, :updated_at, :raw]
  end

  def has_expected_format?
    request_id.blank?
  end

  private

  def capitalize_http_method
    self.http_method.try(:upcase!)
  end


  settings analysis: {
    analyzer: {
      special_characters: {
        type: "custom",
        filter: ["lowercase"],
        tokenizer: "whitespace"
      }
    }
  } do
    mappings dynamic: 'false' do
      indexes :path, analyzer: :special_characters
    end
  end
end
