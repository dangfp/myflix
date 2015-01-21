require 'spec_helper'

describe Video do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }

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
end