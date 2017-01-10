class Bed < ActiveRecord::Base
	belongs_to :nurse
	has_many :bedallotments
	
	scope :sorted, lambda { order("beds.created_at DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
	
	def bedward
  		" #{"0"}#{bednumber} #{"-"} #{wardtype}"
	end

end
#