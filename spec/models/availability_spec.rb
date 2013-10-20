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

    it "should validate that slot duration is a multiple of 15" do
      availability.slot_duration = 23
      availability.should_not be_valid
    end

  end

  context "When recurring" do

    let(:availability) { FactoryGirl.build(:availability) }

    before(:each) do
      recur = availability.build_recur
      recur.every = :week
      recur.ends_at = "1/2/2013"
      availability.save
    end

    it "should create all recurring slots" do
      availability.slots.count.should == 40
    end

  end

end
