class Admin < ActiveRecord::Base

	has_secure_password

	has_many :departments
	has_many :nurses, :through => :departments
	has_many :doctors, :through => :departments
	has_many :accountants, :through => :departments
	has_many :pharmacists, :through => :departments
	has_many :labtechnicians, :through => :departments
	belongs_to :user

	scope :search, lambda {|query|
		where(["doctorname LIKE ?", "%#{query}%"])
	}
end
