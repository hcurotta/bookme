require 'spec_helper'

describe Slot do

  context "Attributes" do

    subject { FactoryGirl.create(:slot) }

    it { should respond_to(:starts_at) }
    it { should respond_to(:ends_at) }
    it { should belong_to(:availability) }

  end

  context "When a slot exists" do

    it "should reject a slot when it overlaps an existing slot" do
      existing_slot = FactoryGirl.build(:slot)
      existing_slot.starts_at  = "1/1/2013 9:00 AM UTC"
      existing_slot.ends_at    = "1/1/2013 11:00 AM UTC"
      existing_slot.save!

      new_slot = FactoryGirl.build(:slot)
      new_slot.starts_at  = "1/1/2013 10:00 AM UTC"
      new_slot.ends_at    = "1/1/2013 10:30 AM UTC"
      new_slot.should_not be_valid

    end

    it "should accept a slot when it is back to back with an existing slot" do
      existing_slot = FactoryGirl.build(:slot)
      existing_slot.starts_at  = "1/1/2013 9:00 AM UTC"
      existing_slot.ends_at    = "1/1/2013 10:00 AM UTC"
      existing_slot.save!

      new_slot = FactoryGirl.build(:slot)
      new_slot.starts_at  = "1/1/2013 10:00 AM UTC"
      new_slot.ends_at    = "1/1/2013 11:30 AM UTC"
      new_slot.should be_valid

    end

    it "should reject a slot when it is the exact same times as an existing slot" do
      existing_slot = FactoryGirl.build(:slot)
      existing_slot.starts_at  = "1/1/2013 9:00 AM UTC"
      existing_slot.ends_at    = "1/1/2013 10:00 AM UTC"
      existing_slot.save!

      new_slot = FactoryGirl.build(:slot)
      new_slot.starts_at  = "1/1/2013 9:00 AM UTC"
      new_slot.ends_at    = "1/1/2013 10:00 AM UTC"
      new_slot.should_not be_valid
    end

  end
end
