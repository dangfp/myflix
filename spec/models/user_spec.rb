require 'spec_helper'

describe User do
  it { should have_secure_password }

  it { should validate_presence_of(:email) }
  it { should allow_value('test@yahoo.cn').for(:email) }
  it { should_not allow_value('yahoo.cn').for(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should validate_presence_of(:password) }
  it { should ensure_length_of(:password).is_at_least(6).is_at_most(20) }

  it { should validate_presence_of(:full_name) }
  it { should ensure_length_of(:full_name).is_at_least(3).is_at_most(20) }

  it { should have_many(:reviews) }
  it { should have_many(:queue_items).order("position ASC") }

  it { should have_many(:relationships) }
  it { should have_many(:followed_users) }

  it { should have_many(:reverse_relationships) }
  it { should have_many(:followers) }

  describe "#queued_video?" do
    let(:janne) { Fabricate(:user) }
    let(:south_park) { Fabricate(:video) }
    it "return true when the user queued the video" do
      queue_item = Fabricate(:queue_item, user: janne, video: south_park)
      expect(janne.queued_video?(south_park)).to be_truthy
    end

    it "return false when the user has't queued the video" do
      expect(janne.queued_video?(south_park)).to be_falsey
    end
  end

  describe "#follow!" do
    let(:janne) { Fabricate(:user) }
    let(:tom) { Fabricate(:user) }

    it "the followed_users should include the other user" do
      janne.follow!(tom)
      expect(janne.followed_users).to include(tom)
    end
  end

  describe "#following?" do
    let(:janne) { Fabricate(:user) }
    let(:tom) { Fabricate(:user) }
    let(:jack) { Fabricate(:user) }

    it "return true when the user followed the other user" do
      janne.follow!(tom)
      expect(janne.following?(tom)).to be_truthy
    end

    it "return false when the user didn't follow the other user" do
      expect(janne.following?(jack)).to be_falsey
    end
  end

  describe "#unfollow!" do
    let(:janne) { Fabricate(:user) }
    let(:tom) { Fabricate(:user) }
    before { janne.follow!(tom) }

    it "the followed_users should not include the other user" do
      janne.unfollow!(tom)
      expect(janne.followed_users).not_to include(tom)
    end
  end
end