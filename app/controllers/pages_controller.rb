class PagesController < ApplicationController
  def index
    @logs = Log.all.sort { |x,y| x.created_at.to_f <=> y.created_at.to_f }.reverse
  end
end
