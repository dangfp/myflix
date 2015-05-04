class ForgotPasswordsController < ApplicationController
  def create
    if params[:email].blank?
      flash[:danger] = "Email cannot be blank."
      redirect_to forgot_password_path
    else
      user = User.find_by(email: params[:email])
      if user
        AppMailer.reset_password_email(user).deliver
        redirect_to forgot_password_confirmation_path
      else
        flash[:danger] = 'Your email is wrong,please input again.'
        redirect_to forgot_password_path
      end
    end
  end
end
