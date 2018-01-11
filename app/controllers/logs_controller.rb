class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    parser = Log::Parser.new(request.raw_post)

    Log.create({
      http_method: parser.method,
      request_id: parser.request_id,
      status: parser.status,
      host: parser.host,
      path: parser.path,
      fwd: parser.fwd,
      timestamp: parser.timestamp
    })
  end
end
