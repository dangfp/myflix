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
end