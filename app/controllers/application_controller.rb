class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def require_sign_in
    if !current_user
      flash[:danger] = "Must be signed in to do that."
      redirect_to sign_in_path
    end
  end
end
