class Accountant < ActiveRecord::Base
	
	has_secure_password

	has_many :invoices
	belongs_to :user
	belongs_to :department

	scope :sorted, lambda { order("accountants.name DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
