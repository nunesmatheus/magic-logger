class Log
  require 'elasticsearch/persistence/model'
  include Elasticsearch::Persistence::Model

  index_name 'logs'

  attribute :created_at, DateTime
  attribute :method, String
  attribute :url, String
  attribute :request_id, String
  attribute :status, String
  attribute :host, String
  attribute :path, String
  attribute :fwd, String
end
