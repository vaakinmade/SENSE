class Labtechnician < ActiveRecord::Base

has_secure_password

	has_many :bloodbanks	
	has_many :blooddonors
	belongs_to :department
	belongs_to :user

	scope :sorted, lambda { order("labtechnicians.name ASC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
