class PagesController < ApplicationController

  before_action :force_authentication
  before_action :set_query_params
  before_action :set_before_log
  before_action :set_per_page

  def index
    @logs = Log::Searcher.search(@query_params, before_log: @before_log, per_page: @per_page)
  end


  private

  def set_before_log
    return if params[:before_log].blank?
    @before_log = Log.find(params[:before_log])
  end

  def set_query_params
    if params[:query].blank?
      @query_params = {}
      return
    end

    parser = Log::Parser.new(params[:query])
    @query_params = parser.attributes
    @query_params[:http_method] = @query_params[:method]
    @query_params[:method] = nil
    @query = parser.raw_log
  end

  def set_per_page
    @per_page = (params[:per_page] || Kaminari.config.default_per_page).to_i
  end
end
