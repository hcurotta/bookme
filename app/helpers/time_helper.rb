module TimeHelper

	# This helper contains methods for working with dates

	# Check if two time periods overlap each other
  def overlaps?(start_date, end_date, other_start_date, other_end_date)
    (start_date - other_end_date) * (other_start_date - end_date) >= 0
  end
  
end