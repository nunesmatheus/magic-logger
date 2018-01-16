class PagesController < ApplicationController

  before_action :force_authentication

  def index
    if params[:before_log]
      @before_log = Log.find(params[:before_log])
    end

    @per_page = params[:per_page] || Kaminari.config.default_per_page
    @per_page = @per_page.to_i

    @logs = Log::Searcher.search(query_params, { before_log: @before_log })
    if query_params.empty?
      @logs = Log::Sorter.sort_by_date(@logs)
    end
    @logs = Kaminari.paginate_array(@logs).page(1).per(@per_page)

    @query_params = query_params
  end


  private

  def query_params
    params.permit(:http_method, :request_id, :status, :host, :path, :fwd, :raw)
  end
end
