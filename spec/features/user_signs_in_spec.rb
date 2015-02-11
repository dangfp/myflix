require 'spec_helper'

feature "User signs in" do
  scenario "with exisiting user" do
    janne = Fabricate(:user)
    sign_in(janne)

    expect(page).to have_content janne.full_name
  end
end