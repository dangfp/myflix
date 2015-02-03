require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer.is_greater_than(0) }

  let!(:janne) { Fabricate(:user) }
  let!(:cartoon) { Fabricate(:category, name: 'Cartoon') }
  let!(:south_park) { Fabricate(:video, title: 'south_park', category_id: cartoon.id) }
  let!(:queue_item1) { Fabricate(:queue_item, video: south_park, user: janne) }

  describe "#video_title" do
    it "returns the title of the associated video" do
      expect(queue_item1.video_title).to eq('south_park')
    end
  end

  describe "#rating" do
    context "the user reviewed the video" do
      let!(:review) { Fabricate(:review, rating: 5, creator: janne, video: south_park) }

      it "returns the rating of the associated review" do
        expect(queue_item1.rating).to eq(5)
      end
    end

    context "the user didn't review the video" do
      let!(:family_guy) { Fabricate(:video, title: 'family_guy, category_id: cartoon.id') }
      let!(:queue_item2) { Fabricate(:queue_item, video: family_guy, user: janne) }

      it "returns nil" do
        expect(queue_item2.rating).to be_nil
      end
    end
  end

  describe "#category_name" do
    it "returns the name of the associated category" do
      expect(queue_item1.category_name).to eq('Cartoon')
    end
  end

  describe "#category" do
    it "returns the category of the associated category" do
      expect(queue_item1.category).to eq(cartoon)
    end
  end
end