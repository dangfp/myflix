require 'spec_helper'

describe Video do
  it "save itself" do
    video = Video.new(title: 'First video', description: 'I liked a video.')
    video.save
    
    expect(Video.first).to eq(video)
  end
end