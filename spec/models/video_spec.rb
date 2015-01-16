require 'spec_helper'

describe Video do
  it "is invalid without title" do
    expect(Video.new(title: nil).errors_on(:title).size).to eq(1)
  end

  it "is invalid without description" do
    expect(Video.new(description: nil).errors_on(:title).size).to eq(1)
  end

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