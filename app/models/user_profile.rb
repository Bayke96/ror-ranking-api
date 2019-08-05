class UserProfile < ApplicationRecord

	// Class variables
	attr_accessor :id, :userfk, :firstname, :lastname, :email, :phonenumber, :address

  // Validators
	belongs_to :user
	validates :userfk, presence: true, numericality: { only_integer: true }
	validates :firstname, presence: true, length: { in: 3..128 }
	validates :lastname, presence: true, length: { in: 3..128 }
	validates :email, presence: true, length: { in: 3..50 }
	validates :phonenumber, presence: true, length: { in: 3..50 }
	validates :address, presence: true, length: { in: 2..128 }

	// Constructors
	def initialize(userfk, firstname, lastname, email, phonenumber, address)
		@userfk = userfk
		@firstname = firstname
		@lastname = lastname
		@email = email
		@phonenumber = phonenumber
		@address = address
	end

end
