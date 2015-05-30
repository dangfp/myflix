class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail(from: 'notifications@Myflix.com', to: @user.email, subject: 'Welcome to Myflix Site')
  end

  def reset_password_email(user)
    @user = user
    mail(from: 'notifications@Myflix.com', to: @user.email, subject: 'reset password')
  end
end