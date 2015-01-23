module ControllerMacros
  def signed_in
    user = Fabricate(:user)
    session[:user_id] = user.id
  end
end