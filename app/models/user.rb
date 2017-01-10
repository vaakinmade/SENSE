class User < ActiveRecord::Base

	has_secure_password

	has_many :admins
	has_many :doctors
	has_many :nurses
	has_many :accountants
	has_many :labtechnicians
	has_many :pharmacists
	has_many :patients
	
	scope :search, lambda {|query|
		where(["doctorname LIKE ?", "%#{query}%"])
	}
end
