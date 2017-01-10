class Bedallotment < ActiveRecord::Base

	belongs_to :nurse
	belongs_to :doctor
	belongs_to :bed
	belongs_to :patient

	scope :sorted, lambda { order("bedallotments.allotmentdate DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

end
