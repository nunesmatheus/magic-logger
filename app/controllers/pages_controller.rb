class PagesController < ApplicationController
  def index
    if query_params.any? { |k,v| v.present? }
      @logs = Log::Searcher.search(query_params)
    else
      @logs = Log::Sorter.sort_by_date(Log.all)
    end

    @query_params = query_params
  end


  private

  def query_params
    params.permit(:http_method, :request_id, :status, :host, :path, :fwd, :raw)
  end
end
