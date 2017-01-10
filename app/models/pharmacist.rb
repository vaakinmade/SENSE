class Pharmacist < ActiveRecord::Base

has_secure_password

	has_many :medicines
	has_many :medicinecategories
	belongs_to :department
	belongs_to :user

	scope :sorted, lambda { order("pharmacists.name DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
