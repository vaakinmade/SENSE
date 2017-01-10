class Patient < ActiveRecord::Base

#has_secure_password
	#validates :name, :inclusion => 1..10

	has_many :appointments
	has_many :doctors, :through => :appointments
	has_many :bedallotments
	belongs_to :user

	scope :sorted, lambda {order("patients.id DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
