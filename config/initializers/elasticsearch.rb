config = {
  url: Rails.application.secrets.elasticsearch_url,
  log: Rails.env.development?,
  adapter: :net_http,
  transport_options: {
    request: { timeout: 10 }
  },
}

config[:log] = false if Rails.env.test?

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
Elasticsearch::Persistence.client = Elasticsearch::Client.new(config)
