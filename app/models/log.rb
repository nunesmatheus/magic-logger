# TODO: Should be HttpLog
class Log
  require 'elasticsearch/persistence/model'
  include Elasticsearch::Persistence::Model

  # TODO: Always capitalize method before saving, etc

  index_name "log_#{Rails.env}"

  attribute :http_method, String
  attribute :request_id, String
  attribute :status, String
  attribute :host, String
  attribute :path, String, mapping: { analyzer: 'special_characters' }
  attribute :fwd, String
  attribute :raw, String

  def to_s
    return raw if request_id.blank?

    self.class.attributes_order.map(&:to_sym).map do |attribute|
      "#{attribute}=#{self.send(attribute).to_s}"
    end.join(" ")
  end

  def self.attributes_order
    %w(created_at http_method host path status fwd request_id)
  end

  def self.attributes
    self.attribute_set.entries.map(&:name)
  end

  def self.relevant_attributes
    self.attributes - [:updated_at, :raw]
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
