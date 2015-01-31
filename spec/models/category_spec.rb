require 'spec_helper'

describe Category do
  it { should validate_presence_of(:name) }
  it { should have_many(:videos) }

  describe "#recent_videos" do
    let(:cartoon) { Fabricate(:category) }
    subject { category.recent_videos }

    context "order by created_at DESC" do
      let(:video1) { Fabricate(:video, created_at: 1.day.ago, category: cartoon) }
      let(:video2) { Fabricate(:video, category: cartoon) }

      it { expect eq([video2, video1]) }
    end

    context "no videos" do
      it { expect eq([]) }
    end

    context "less than 6" do
      before { Fabricate.times(5, :video, category: cartoon) }

      it { expect(cartoon.recent_videos.count).to eq(5) }
    end

    context "more than or equal 6" do
      before { Fabricate.times(7, :video, category: cartoon) }

      it { expect(cartoon.recent_videos.count).to eq(6) }
    end

    context "the most recent 6 videos" do
      let(:south_park) { Fabricate(:video, created_at: 1.day.ago, category: cartoon) }
      before { Fabricate.times(6, :video, category: cartoon) }
        
      it { expect(cartoon.recent_videos).not_to include(@south_park) }
    end
  end
end