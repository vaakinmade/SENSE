class Department < ActiveRecord::Base

	has_many :doctors
	has_many :nurses
	belongs_to :admin

	scope :sorted, lambda { order("departments.name DESC") }
	scope :search, lambda {|query|
		where(["doctorname LIKE ?", "%#{query}%"])
	}
end
