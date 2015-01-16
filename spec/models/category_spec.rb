require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: 'Cartoon')
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    cartoon = Category.create(name: 'Cartoon')
    monk = Video.create(title: 'monk', description: 'pretty video.', category: cartoon)
    family_guy = Video.create(title: 'family_guy', description: 'Funny video.', category: cartoon)
    
    expect(cartoon.videos).to eq([family_guy, monk])
  end
end