require 'spec_helper'

describe Category do
  it { should validate_presence_of(:name) }
  it { should have_many(:videos) }

  describe "#recent_videos" do
    before(:each) do
      @cartoon = Category.create(name: 'cartoon')
    end

    it "returns an empty array when the category does not have any videos" do
      expect(@cartoon.recent_videos).to eq([])
    end

    it "returns the videos order by created_at DESC" do
      south_park = Video.create(title: 'south_park', description: 'be created one day ago.', created_at: 1.day.ago, category: @cartoon)
      monk = Video.create(title: 'monk', description: 'Wonderful!', category: @cartoon)
      expect(@cartoon.recent_videos).to eq([monk, south_park])
    end

    it "returns all videos when the videos total less than 6" do
      5.times { Video.create(title: 'test video', description: 'test...', category: @cartoon) }
      expect(@cartoon.recent_videos.count).to eq(5)
    end

    it "returns only 6 videos when the video total greater than or equal 6" do
      7.times { Video.create(title: 'test video', description: 'test...', category: @cartoon) }
      expect(@cartoon.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      6.times { Video.create(title: 'test video', description: 'test...', category: @cartoon) }
      south_park = Video.create(title: 'south_park', description: 'be created one day ago.', created_at: 1.day.ago, category: @cartoon)
      expect(@cartoon.recent_videos).not_to include(south_park)
    end
  end
end