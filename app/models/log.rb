class Log
  require 'elasticsearch/persistence/model'
  include Elasticsearch::Persistence::Model

  # TODO: Always capitalize method before saving, etc

  index_name 'logs'

  attribute :http_method, String
  attribute :request_id, String
  attribute :status, String
  attribute :host, String
  attribute :path, String
  attribute :fwd, String

  def to_s
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
    self.attributes - [:updated_at]
  end
end
