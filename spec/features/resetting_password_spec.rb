require 'spec_helper'

feature "Resetting password" do
  scenario "reset password with valid info" do
    janne = Fabricate(:user, email: 'janne@example.com', password: '123456', full_name: 'janne')

    visit sign_in_path
    click_link 'Forgot Password'

    fill_in 'email', with: janne.email
    click_button 'Send Email'

    open_email(janne.email)
    current_email.click_link 'Reset My Password'

    fill_in 'password', with: '111111'
    click_button 'Reset Password'
    expect(page).to have_content 'Your password has be changed,please sign in again.'
    expect(page).to have_button 'Sign in'

    fill_in 'email', with: janne.email
    fill_in 'password', with: '111111'
    click_button 'Sign in'
    expect(page).to have_content "Welcome, #{janne.full_name}"
  end

  scenario "reset password with invalid email" do
    janne = Fabricate(:user, email: 'janne@example.com', password: '123456', full_name: 'janne')

    visit sign_in_path
    click_link 'Forgot Password'

    fill_in 'email', with: 'wrong@example.com'
    click_button 'Send Email'
    expect(page).to have_content "Your email is wrong,please input again."
  end
end