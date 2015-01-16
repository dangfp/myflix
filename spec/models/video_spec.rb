require 'spec_helper'

describe Video do
  it "is invalid without title"

  it "is invalid without description"

  it "save itself" do
    video = Video.new(title: 'First video', description: 'I liked a video.')
    video.save

    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    cartoon = Category.create(name: 'Cartoon')
    monk = Video.create(title: 'monk', description: 'Funny video.', category: cartoon)

    expect(monk.category).to eq(cartoon)
  end
end