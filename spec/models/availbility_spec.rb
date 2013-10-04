require 'spec_helper'

describe Availability do

  let(:availability) { FactoryGirl.create(:availability) }

  subject { availability }

  it { should respond_to(:starts_at) }
  it { should respond_to(:ends_at) }
  it { should respond_to(:slot_duration) }

  context "After saving" do

    it "should create 8 availabilty slots when saved" do
      availability.slots.count.should == 8
    end

    it "should create slots that are the correct duration" do
      slot = availability.slots.first
      ((slot.ends_at - slot.starts_at) / 60 ).to_i.should == availability.slot_duration
    end

    it "should create slots that do not end after the end of the availability period" do
      slot = availability.slots.last
      slot.ends_at.should be <= availability.ends_at
    end

  end
end
