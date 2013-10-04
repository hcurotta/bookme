class Slot < ActiveRecord::Base
  attr_accessible :availability_id, :ends_at, :starts_at, :availability

  belongs_to :availability

  validate :does_not_overlap_existing_slot

  include TimeHelper

  def does_not_overlap_existing_slot

  	self.errors.add(:base, "slot already exists for this time") unless Slot.where("ends_at > ? AND starts_at < ?", starts_at, ends_at).empty?

  	# if existing end date is after new start date
  	# AND
  	# If existing start date is before new end date 
  end

end


