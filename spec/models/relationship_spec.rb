require 'spec_helper'

describe Relationship do
  it { belong_to(:follower).class_name('User') }
  it { belong_to(:followed).class_name('User') }
end