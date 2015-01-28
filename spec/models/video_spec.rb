require 'spec_helper'

describe Video do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }
  it { should have_many(:reviews).order("created_at DESC") }

  describe "#search_by_title" do
    let(:family_guy)  { Fabricate(:video, title: 'family_guy') }
    let(:south_years) { Fabricate(:video, title: 'south_years') }
    let(:south_park)  { Fabricate(:video, title: 'south_park') }

    context "non-matching title" do
      it "return an empty array for an empty string" do
        expect(Video.search_by_title(' ')).to eq([])
      end

      it "renturn an empty array for a non-empty string" do
        expect(Video.search_by_title('monk')).to eq([])
      end
    end

    context "matching title" do
      it "returns an array one video for an exact match" do
        expect(Video.search_by_title('family_guy')).to eq([family_guy])
      end

      it "returns an array one video for an partial match" do
        expect(Video.search_by_title('guy')).to eq([family_guy])
      end

      it "returns an array of all matches videos" do
        expect(Video.search_by_title('south')).to match_array([south_park, south_years])
      end

      it "returns an array of videos order by title ASC" do
        expect(Video.search_by_title('south')).to eq([south_park, south_years])
      end
    end
  end

  describe "#rating" do
    let(:south_park) { Fabricate(:video) }

    context "have user rating" do
      before do
        review1 = Fabricate(:review, rating: 5, video: south_park)
        review2 = Fabricate(:review, rating: 1, video: south_park)
      end

      it "returns the average value of all user rating for the video" do
        expect(south_park.rating).to eq(3)
      end

      it "keep a decimal" do
        review3 = Fabricate(:review, rating: 4, video: south_park)
        expect(south_park.rating).to eq(3.3)
      end
    end
    
    context "no user rating" do
      it "returns 0" do
        expect(south_park.rating).to eq(0)
      end
    end
  end
end