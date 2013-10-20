FactoryGirl.define do
  factory :availability do
    starts_at       "1/1/2013 10:00 AM UTC"
    ends_at         "1/1/2013 2:00 PM UTC" 
    slot_duration   30
  end

  factory :slot do
    starts_at       "1/1/2013 10:00 AM UTC"
    ends_at         "1/1/2013 10:30 AM UTC" 
  end
end