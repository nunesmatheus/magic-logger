class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :force_authentication, :signed_in?

  def signed_in?
    session[:signed_in] == true
  end

  def force_authentication
    redirect_to new_session_path unless signed_in?
  end
end
