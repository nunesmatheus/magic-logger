class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:password] == Rails.application.secrets.dashboard_password
      session[:signed_in] = true
      redirect_to root_path
    else
      render :new
    end
  end
end
