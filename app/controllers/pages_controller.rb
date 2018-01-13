class PagesController < ApplicationController
  def index
    if query_params.any? { |k,v| v.present? }
      # que porra é essa velho
      @logs = Log::Searcher.search(query_params).sort do |x,y|
        x.created_at.to_f <=> y.created_at.to_f
      end.reverse
    else
      @logs = Log.all
    end

    @query_params = query_params
  end


  private

  def query_params
    params.permit(:http_method, :request_id, :status, :host, :path, :fwd, :raw)
  end
end
