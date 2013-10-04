class Availability < ActiveRecord::Base
  attr_accessible :ends_at, :slot_duration, :starts_at


  has_many   :slots
  belongs_to :user

  after_create :create_slots

  # validate that slot duration is always a multiple of 15
  


  def create_slots
  	length = ((ends_at - starts_at) / 60).to_i

  	num_slots = (length / slot_duration).to_i

  	num_slots.times do |i|
  		Slot.create!({:starts_at				=> (starts_at + (slot_duration.minutes * i)),
  								 :ends_at					=> (starts_at + (slot_duration.minutes * (i+1))),
  								 :availability_id	=> id})
		end
  end
end
