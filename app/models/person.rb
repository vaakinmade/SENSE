class Person < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :first_name, :length => {:minimum => 2}
  #validates :last_name, presence: true
end
