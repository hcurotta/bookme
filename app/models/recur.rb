class Recur < ActiveRecord::Base
  attr_accessible :availability_id, :ends_at, :every

  belongs_to :availability
end
