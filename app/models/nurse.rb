class Nurse < ActiveRecord::Base

has_secure_password

	has_many :beds
	has_many :bedallotments
	#has_many :appointments
	belongs_to :department
	belongs_to :user

	scope :sorted, lambda { order("nurses.name DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
