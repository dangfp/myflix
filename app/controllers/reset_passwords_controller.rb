class ResetPasswordsController < ApplicationController
  def show
    user = User.find_by(token: params[:id]) if params[:id]
    if user
      @token = user.token
    else
      redirect_to expired_token_path
    end
  end

  def create
    user = User.find_by(token: params[:token]) if params[:token]

    if user
      old_token = user.token

      user.password = params[:password]
      user.generate_token

      if user.save
        flash[:success] = "Your password has be changed,please sign in again."
        redirect_to sign_in_path
      else
        id = old_token
        flash[:danger] = "The new password is invalid,please reset."
        redirect_to reset_password_path(old_token)
      end
    else
      redirect_to expired_token_path
    end
  end
end