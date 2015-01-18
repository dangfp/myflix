require 'spec_helper'

describe Video do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }

  describe "#search_by_title" do
    before(:each) do
      cartoon = Category.create(name: 'cartoon')
      @family_guy = Video.create(title: 'family_guy', description: 'Very funny.', category: cartoon)
      @south_years = Video.create(title: 'south_years', description: 'Classic', category: cartoon)
      @south_park = Video.create(title: 'south_park', description: 'Wonderful', category: cartoon)
    end

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
        expect(Video.search_by_title('family_guy')).to eq([@family_guy])
      end

      it "returns an array one video for an partial match" do
        expect(Video.search_by_title('guy')).to eq([@family_guy])
      end

      it "returns an array of all matches videos order by title" do
        expect(Video.search_by_title('south')).to eq([@south_park, @south_years])
      end
    end
  end
end