module FeatureMacros
  def sign_in(a_user=nil)
    user = a_user || Fabricate(:user)

    visit sign_in_path
    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end