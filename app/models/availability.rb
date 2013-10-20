class Availability < ActiveRecord::Base
  attr_accessible :ends_at, :slot_duration, :starts_at, :recurrence_attributes

  has_many    :slots, dependent: :destroy
  belongs_to  :user
  has_one     :recur

  after_create :create_slots

  accepts_nested_attributes_for :recur, allow_destroy: true


  # validate that slot duration is always a multiple of 15
  validate :slot_duration_is_multiple_of_15

  def create_slots

  	length = ((ends_at - starts_at) / 60).to_i

  	num_slots = (length / slot_duration).to_i

    if self.recur.present?
      dates = Recurrence.new(every: :week, on: starts_at.strftime("%A").downcase, starts: starts_at.to_date, :until => recur.ends_at.to_date)
    else 
      dates = [starts_at.to_date]
    end

    dates.each do |date|
      slot_starts_at = "#{date} #{starts_at.strftime('%H')}:#{starts_at.strftime('%M')}".to_time

    	num_slots.times do |i|
    		Slot.create!({:starts_at	=> (slot_starts_at + (slot_duration.minutes * i)),
    								 :ends_at					=> (slot_starts_at + (slot_duration.minutes * (i+1))),
    								 :availability_id	=> id})
      end
		end
  end

  def slot_duration_is_multiple_of_15
    self.errors.add(:base, "duration must be a multiple of 15") unless (slot_duration % 15) == 0
  end

end
