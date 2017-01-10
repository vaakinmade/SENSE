class Doctor < ActiveRecord::Base

has_secure_password
	
	has_many :appointments
	has_many :patients, :through => :appointments
	has_many :bedallotments
	belongs_to :department
	belongs_to :user
	
	scope :sorted, lambda { order("doctors.name DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

end
