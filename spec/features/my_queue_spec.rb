require 'spec_helper'

feature "My queue" do
  scenario "Add video to my queue" do
    janne = Fabricate(:user)
    cartoon = Fabricate(:category)
    south_park = Fabricate(:video, title: 'south_park', category: cartoon)
    family_guy = Fabricate(:video, title: 'family_guy', category: cartoon)

    sign_in(janne)

    add_video_to_queue(south_park)
    expect_video_to_be_in_queue(south_park)

    visit video_path(south_park)
    expect_link_not_to_be_seen("+ My Queue")

    add_video_to_queue(family_guy)

    set_video_position(south_park, 2)
    set_video_position(family_guy, 1)
    
    update_queue

    expect_video_position(south_park, 2)
    expect_video_position(family_guy, 1)
  end
end

def add_video_to_queue(video)
  visit home_path
  find("a[href='/videos/#{video.id}']").click
  click_link "+ My Queue"
end

def expect_video_to_be_in_queue(video)
  expect(page).to have_content video.title
end

def expect_link_not_to_be_seen(link_text)
  expect(page).not_to have_content link_text
end

def set_video_position(video, position)
  fill_in "video_#{video.id}", with: position
end

def update_queue
  click_button "Update Instant Queue"
end

def expect_video_position(video, position)
  expect(find("#video_#{video.id}").value).to eq(position.to_s)
end