class SessionsController < ApplicationController
  def new
    redirect_to home_path if signed_in?
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You've signed in."
      redirect_to home_path
    else
      flash[:error] = "There's something wrong with your email or password."
      redirect_to sign_in_path
    end
  end

  def destory
    session[:user_id] = nil
    redirect_to root_path
  end
end