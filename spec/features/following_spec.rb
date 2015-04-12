require 'spec_helper'

feature "User following" do
  scenario "follows one user and unfollows the followed user" do
    janne = Fabricate(:user)
    tom = Fabricate(:user)
    cartoon = Fabricate(:category)
    south_park = Fabricate(:video, title: 'south_park', category: cartoon)
    family_guy = Fabricate(:video, title: 'family_guy', category: cartoon)
    review = Fabricate(:review, user_id: tom.id, video_id: south_park.id, rating: 5, content: 'very intresting')

    sign_in(janne)

    visit video_path(south_park)
    click_link tom.full_name
    click_link 'Follow'
    expect(page).to have_content tom.full_name

    click_link tom.full_name
    expect(page).not_to have_content 'Follow'

    visit following_user_path(janne)
    unfollows(tom)
    expect(page).not_to have_content tom.full_name
  end

  def unfollows(other_user)
    find("a[href='/relationships/#{other_user.id}']").click
  end
end